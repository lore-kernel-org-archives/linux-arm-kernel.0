From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 26 Nov 2013 09:26:40 +0100
Subject: [PATCH v2 1/2] can + ARM i.MX53: use 24 MHz clock parent on i.MX53
In-Reply-To: <20131126045340.GJ30476@S2101-09.ap.freescale.net>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
 <20131126045340.GJ30476@S2101-09.ap.freescale.net>
Message-ID: <52945B40.5020200@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 05:53 AM, Shawn Guo wrote:
>> this series first fixes a bug in the flexcan driver, using the wrong clock for
>> the bit rate calculcation. The next patch switches the peripheral clock on
>> i.MX53 to lp_apm, which has a rate of 24 MHz. This is optimal for the CIA
>> recommended bit rates.
>>
>> Tested on TQ's mba53 and mba6x [1].
>>
>> Who is taking the series? Due to Lucas' patch:
>>
>>     0a5b8df clk: imx5: introduce DT includes for clock provider
>>
>> this series does not yet apply to my upstream (net-next/mastet).
> 
> If the clock setting in flexcan driver is already broken, it shouldn't
> matter to have two patches go different tree?  Otherwise, I can have
> both go via IMX tree with your ACK on the first one?

The problem is, that the wrong clock is being used. An all i.mx, but not
on imx6, both clocks are the same, the bug doesn't show up. So before we
can use the 24 MHz clock on mx53, we have to fix the driver.

Feel free to add my Acked-by to the first patch and take it via your tree.

>> [1] On i.MX6 the following patch is needed (which is already in Shawn's
>>     for-next):
>>
>>     9b3d423 ARM: i.MX6q: fix the wrong parent of can_root clock
> 
> This one already hits mainline.

But not net-next/master, which is my upstream.

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/99d84532/attachment.sig>
