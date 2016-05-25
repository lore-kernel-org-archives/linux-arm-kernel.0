From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 May 2016 12:07:56 -0300
Subject: [PATCH 2/2] ARM: dts: imx6q: add support for the Utilite Pro
In-Reply-To: <0cf90ebe86e0461f82cb22b2a6b6ea83@rwthex-s1-b.rwth-ad.de>
References: <1463957258-4893-1-git-send-email-christopher.spinrath@rwth-aachen.de>
 <c4ab0387041f42ada68296141befe332@rwthex-s1-b.rwth-ad.de>
 <20abc2f6769b4369ba87ec27274a090e@rwthex-s2-a.rwth-ad.de>
 <644530ff6bb04b5898dc33604dc7a93a@rwthex-s1-b.rwth-ad.de>
 <9b905766c6cc4680be4b33f79a179d5a@rwthex-w1-b.rwth-ad.de>
 <0cf90ebe86e0461f82cb22b2a6b6ea83@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5DpTrxE+=d6saCowkncR=xpDY060_uTV_WGYxoN7dKUpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 11:05 AM, Christopher Spinrath
<christopher.spinrath@rwth-aachen.de> wrote:

> OK, done. Can I always use the default value in this case? If yes, can
> you point me to a proper documentation of these?

You can look at
"36.4.316 Pad Control Register
(IOMUXC_SW_PAD_CTL_PAD_ENET_TX_DATA1)" in the mx6quad reference manual.

For GPIO functionality the default power-on-reset value should work fine.

You can confirm this by reading address 0x20E0500 in the bootloader:
mw.l 0x20E0500 1

and then use this value on the dts. This way the kernel will always
have a sane value instead of relying in the value passed from the
bootloader.
