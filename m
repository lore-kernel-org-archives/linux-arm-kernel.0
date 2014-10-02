From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 2 Oct 2014 11:37:42 +1000
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20141002113742.2b521495@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/boot/dts/exynos5250-snow.dts:13:46: fatal error: dt-bindings/clock/maxim,max77686.h: No such file or directory
 #include <dt-bindings/clock/maxim,max77686.h>
                                              ^

Caused by commit c04c92ed5614 ("ARM: dts: Add rtc_src clk for s3c-rtc
on exynos5250-snow").

Presumably there is some dependency on some tree that someone has
forgotten to merge :-(

I reverted that commit for today.

Which then got to:

/scratch/sfr/next/arch/arm/boot/dts/exynos5420-peach-pit.dts:15:46: fatal error: dt-bindings/clock/maxim,max77802.h: No such file or directory
 #include <dt-bindings/clock/maxim,max77802.h>
                                              ^
compilation terminated.
/scratch/sfr/next/arch/arm/boot/dts/exynos5800-peach-pi.dts:15:46: fatal error: dt-bindings/clock/maxim,max77802.h: No such file or directory
 #include <dt-bindings/clock/maxim,max77802.h>
                                              ^
compilation terminated.
Error: /scratch/sfr/next/arch/arm/boot/dts/hisi-x5hd2.dtsi:417.21-22 syntax error
FATAL ERROR: Unable to parse input tree

Caused by 8bd43b6e6df7 ("ARM: dts: Add rtc_src clk for s3c-rtc on
exynos Peach boards").

I give up ... please test your trees better ...

I have used the arm-soc tree form next-20141001 for today (which still
needs 5 reverts to get it to build :-().
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141002/a84b5526/attachment.sig>
