From: balbi@ti.com (Felipe Balbi)
Date: Fri, 6 Nov 2015 08:06:47 -0600
Subject: Linus HEAD build break
Message-ID: <871tc31atk.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Marek,

your commit af19161aaed7 ("ARM: dts: twl4030: Add iio properties for bci
subnode") breaks build on current linus/master (which current sits in
d1e41ff11941 Merge tag 'platform-drivers-x86-v4.4-1' of
git://git.infradead.org/users/dvhart/linux-platform-drivers-x86) for
anybody including twl4030.dtsi because it refers to a non-existent
twl4030_madc label. Build output of make V=1 dtbs:

<stdin>:1304:2: warning: #warning syscall mlock2 not implemented [-Wcpp]
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap2430-sdp.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap2430-sdp.dtb] Error 2
make[2]: *** Waiting for unfinished jobs....
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3430-sdp.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3430-sdp.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dtb' failed
make[2]: *** [arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dtb] Error 2
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-beagle.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-beagle.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-beagle-xm-ab.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-beagle-xm-ab.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-cm-t3530.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-cm-t3530.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-beagle-xm.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-beagle-xm.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-devkit8000.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-devkit8000.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-gta04a4.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-gta04a4.dtb] Error 2
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-gta04a3.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-gta04a3.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-evm-37xx.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-evm-37xx.dtb] Error 2
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-evm.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-evm.dtb] Error 2
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-cm-t3730.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-cm-t3730.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-gta04a5.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-gta04a5.dtb] Error 2
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-devkit8000-lcd70.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-devkit8000-lcd70.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "twl4030_madc"

ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:293: recipe for target 'arch/arm/boot/dts/omap3-devkit8000-lcd43.dtb' failed
make[2]: *** [arch/arm/boot/dts/omap3-devkit8000-lcd43.dtb] Error 2
arch/arm/Makefile:338: recipe for target 'dtbs' failed
make[1]: *** [dtbs] Error 2
Makefile:146: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2

Reverting that commit makes it build again.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/37838ef1/attachment-0001.sig>
