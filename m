From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 20 Nov 2013 18:20:23 +0100
Subject: [PATCH 5/9] ARM: at91/dt: add mmc0 slot0 support to at91rm9200ek
 board
In-Reply-To: <528CDFFB.1020601@overkiz.com>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
 <1377687995-10758-1-git-send-email-b.brezillon@overkiz.com>
 <20131120145926.GE14627@ns203013.ovh.net>
 <528CDFFB.1020601@overkiz.com>
Message-ID: <20131120172023.GI14627@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:14 Wed 20 Nov     , boris brezillon wrote:
> On 20/11/2013 15:59, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >On 13:06 Wed 28 Aug     , Boris BREZILLON wrote:
> >>Add slot0 of mmc0 pinctrl pins definitions:
> >>  - detect pin
> >>  - write protect pin
> >>  - enable slot0 pin: this pin is connected to an external switch which
> >>    enable mmc0 slot0 or spi dataflash connected to cs3
> >>
> >>The mmc0 device is not enabled, as it depends on the choosen functionnality
> >>(spi cs3 or mmc0 slot0).
> >>
> >>Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> >>---
> >>  arch/arm/boot/dts/at91rm9200ek.dts |   35 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 35 insertions(+)
> >>
> >>diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
> >>index f2d6d79..2bad423 100644
> >>--- a/arch/arm/boot/dts/at91rm9200ek.dts
> >>+++ b/arch/arm/boot/dts/at91rm9200ek.dts
> >>@@ -39,6 +39,23 @@
> >>  						atmel,pins = <AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_MULTI_DRIVE>;
> >>  					};
> >>  				};
> >>+
> >>+				mmc0 {
> >>+					pinctrl_mmc0_slot0_detect: mmc0_slot0_detect-0 {
> >>+						atmel,pins =
> >>+							<AT91_PIOB 27 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
> >>+					};
> >>+
> >>+					pinctrl_mmc0_slot0_write_protect: mmc0_slot0_write_protect-0 {
> >>+						atmel,pins =
> >>+							<AT91_PIOA 17 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> >>+					};
> >>+
> >>+					pinctrl_mmc0_slot0_switch: mmc0_slot0_switch-0 {
> >>+						atmel,pins =
> >>+							<AT91_PIOB 22 AT91_PERIPH_GPIO (AT91_PINCTRL_OUTPUT | AT91_PINCTRL_OUTPUT_VAL(1))>;
> >>+					};
> >nack this is a regulator the pinctrl API is not done for gpio default value
> 
> I know this can be represented as a regulator, but looking at the
> datasheet, this looks more
> like a switch than a regulator.

so you load the dt via user space and use the regulator NOT the pinctrl

I do not want to see gpio control via pinctrl as we have no tracability of it
in gpio lib what so ever

> 
> Anyway, why didn't you told me that when I proposed the OUTPUT
> support for at91 pinctrl driver ?

you never get my Ack for this and I'm the pinctrl-at91 maintainer

so NACK

Best Regards,
J.
