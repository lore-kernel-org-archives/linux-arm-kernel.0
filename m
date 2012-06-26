From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 26 Jun 2012 13:43:11 +0200
Subject: [PATCH] MXS: Enable FLEXCAN for MXS/DT
In-Reply-To: <20120626112804.GC8858@S2101-09.ap.freescale.net>
References: <1338084709-12043-1-git-send-email-marex@denx.de>
 <4FE97B12.8040306@pengutronix.de> <4FE97BCC.7050904@pengutronix.de>
 <20120626112804.GC8858@S2101-09.ap.freescale.net>
Message-ID: <4FE9A04F.8030109@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2012 01:28 PM, Shawn Guo wrote:
> On Tue, Jun 26, 2012 at 11:07:24AM +0200, Marc Kleine-Budde wrote:
>>> +       select HAVE_CAN_FLEXCAN if NET && CAN
>>
>> ...and put this select to MACH_MXS_DT, instead of SOC_IMX28
>>
> Hmm, why?  Flexcan is a feature/block of SoC rather than a machine,
> isn't it?

Yes, but the HAVE_CAN_FLEXCAN is used to make the driver available in
Kconfig. What about removing the "depends on HAVE_CAN_FLEXCAN" from the
driver symbol in Kconfig? I can push it via net-next and it will be
mainline in 3.6. You can remove the HAVE_CAN_FLEXCAN from the ARM (and
powerpc) trees.

To avoid Kconfig hickups I'll keep the HAVE_CAN_FLEXCAN symbol in the
net-tree as long as the select HAVE_CAN_FLEXCAN is still present.

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
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120626/e1a388a0/attachment.sig>
