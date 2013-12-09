From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 09 Dec 2013 10:52:33 +0100
Subject: [PATCH v5 09/15] usb: phy-mxs: Enable IC fixes for related SoCs
In-Reply-To: <20131209090749.GB5291@shlinux1.ap.freescale.net>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-10-git-send-email-peter.chen@freescale.com>
 <52A58179.2050702@pengutronix.de>
 <20131209090749.GB5291@shlinux1.ap.freescale.net>
Message-ID: <52A592E1.7040506@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 10:07 AM, Peter Chen wrote:
> On Mon, Dec 09, 2013 at 09:38:17AM +0100, Marc Kleine-Budde wrote:
>> On 12/09/2013 07:30 AM, Peter Chen wrote:
>>> Some PHY bugs are fixed by IC logic, but these bits are not
>>> enabled by default, so we enable them at driver.
>>
>> Which bugs are fixed by enabling this bit? Is it only suspend related?
>> Can you document them or better add a pointer to the documentation.
> 
> I will add more, in fact, it fixes the bug which flag BIT(1) and BIT(2)
> stands for.
> 
>>
>> Further I don't like the idea of adding code, or enabling a feature on
>> certain hardware, that is broken in the first place and fixing it in a
>> later patch. Think about squashing it into the correct patch.
> 
> No fixes are related with this patch, you can see there is no "-"
> at this patch.

Yes, there isn't any broken code (thus no "-"), but you first enable a
feature in the hardware and in a later patch (this one) make it work
properly.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/6e0b29e2/attachment-0001.sig>
