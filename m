From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 03 Dec 2013 11:54:35 +0100
Subject: [PATCH v2 1/2] can + ARM i.MX53: use 24 MHz clock parent on i.MX53
In-Reply-To: <20131126143258.GA5685@S2101-09.ap.freescale.net>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
 <20131126045340.GJ30476@S2101-09.ap.freescale.net>
 <52945B40.5020200@pengutronix.de>
 <20131126143258.GA5685@S2101-09.ap.freescale.net>
Message-ID: <529DB86B.9010401@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On 11/26/2013 03:33 PM, Shawn Guo wrote:
> On Tue, Nov 26, 2013 at 09:26:40AM +0100, Marc Kleine-Budde wrote:
>> The problem is, that the wrong clock is being used. An all i.mx, but not
>> on imx6, both clocks are the same, the bug doesn't show up. So before we
>> can use the 24 MHz clock on mx53, we have to fix the driver.
> 
> So it sounds like a more appropriate merging path would be that,
> you send the driver fix right away to mainline via net tree with
> v3.13-rc series, and I rebase IMX tree on the -rc that has the fix,
> and then apply the DTS patch.

The patch is now in Linus master:
1a3e517 can: flexcan: use correct clock as base for bit rate calculation

So it should be in the v3.13-rc3.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/53fa4558/attachment.sig>
