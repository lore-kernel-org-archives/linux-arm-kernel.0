From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 7 Apr 2015 11:12:17 +1000
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20150407111217.2b2cf440@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from arch/arm/boot/dts/mt8135.dtsi:18:0,
                 from arch/arm/boot/dts/mt8135-evbp1.dts:16:
arch/arm/boot/dts/mt8135-pinfunc.h:18:40: fatal error: dt-bindings/pinctrl/mt65xx.h: No such file or directory
 #include <dt-bindings/pinctrl/mt65xx.h>
                                        ^

Caused by commit e6f219b8ec5e ("ARM: dts: mt8135: Add pinctrl/GPIO/EINT
node for mt8135").

I have reverted that commit for today.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150407/66fa8ace/attachment.sig>
