From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 20:34:49 +1100
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
Message-ID: <20121126203449.10d0d757dcddab773b308ee2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/Makefile between commit ec6754a7b9e9 ("arm: at91: dt:
at91sam9 add serial pinctrl support") from the pinctrl tree and commit
e8d623986990 ("Merge branch 'next/soc' into for-next") from the arm-soc
tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/Makefile
index 204fd3c,cce80e2..0000000
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@@ -1,38 -1,25 +1,41 @@@
  ifeq ($(CONFIG_OF),y)
  
 -dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb \
 -	at91sam9263ek.dtb \
 -	at91sam9g20ek_2mmc.dtb \
 -	at91sam9g20ek.dtb \
 -	at91sam9g25ek.dtb \
 -	at91sam9m10g45ek.dtb \
 -	at91sam9n12ek.dtb \
 -	ethernut5.dtb \
 -	evk-pro3.dtb \
 -	kizbox.dtb \
 -	tny_a9260.dtb \
 -	tny_a9263.dtb \
 -	tny_a9g20.dtb \
 -	usb_a9260.dtb \
 -	usb_a9263.dtb \
 -	usb_a9g20.dtb
 +# Keep at91 dtb files sorted alphabetically for each SoC
 +# rm9200
 +dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
 +# sam9260
 +dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
 +dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb
 +dtb-$(CONFIG_ARCH_AT91) += ethernut5.dtb
 +dtb-$(CONFIG_ARCH_AT91) += evk-pro3.dtb
 +dtb-$(CONFIG_ARCH_AT91) += tny_a9260.dtb
 +dtb-$(CONFIG_ARCH_AT91) += usb_a9260.dtb
 +# sam9263
 +dtb-$(CONFIG_ARCH_AT91) += at91sam9263ek.dtb
 +dtb-$(CONFIG_ARCH_AT91) += tny_a9263.dtb
 +dtb-$(CONFIG_ARCH_AT91) += usb_a9263.dtb
 +# sam9g20
 +dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek.dtb
 +dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek_2mmc.dtb
 +dtb-$(CONFIG_ARCH_AT91) += kizbox.dtb
 +dtb-$(CONFIG_ARCH_AT91) += tny_a9g20.dtb
 +dtb-$(CONFIG_ARCH_AT91) += usb_a9g20.dtb
 +# sam9g45
 +dtb-$(CONFIG_ARCH_AT91) += at91sam9m10g45ek.dtb
 +dtb-$(CONFIG_ARCH_AT91) += pm9g45.dtb
 +# sam9n12
 +dtb-$(CONFIG_ARCH_AT91) += at91sam9n12ek.dtb
 +# sam9x5
 +dtb-$(CONFIG_ARCH_AT91) += at91sam9g15ek.dtb
 +dtb-$(CONFIG_ARCH_AT91) += at91sam9g25ek.dtb
 +dtb-$(CONFIG_ARCH_AT91) += at91sam9g35ek.dtb
 +dtb-$(CONFIG_ARCH_AT91) += at91sam9x25ek.dtb
 +dtb-$(CONFIG_ARCH_AT91) += at91sam9x35ek.dtb
 +
+ dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb
  dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
+ dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
+ 	da850-evm.dtb
  dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
  	dove-cubox.dtb \
  	dove-dove-db.dtb
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/58f7f41a/attachment.sig>
