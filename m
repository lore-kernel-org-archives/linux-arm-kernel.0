From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 29 Jul 2013 07:52:56 +0000 (UTC)
Subject: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping for
 every GPIO on DT"
Message-ID: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

your commit 0e970cec05635adbe7b686063e2548a8e4afb8f4 ("gpio/omap: don't 
create an IRQ mapping for every GPIO on DT") breaks the boot on the 
OMAP5912 OSK:

http://www.pwsan.com/omap/testlogs/bisect_5912osk_boot_fail_v3.11-rc3/20130729013931/boot/5912osk/5912osk_log.txt

This test included a stripped-down version of your commit 
949eb1a4d29dc75e0b5b16b03747886b52ecf854 ("gpio/omap: fix build error when 
OF_GPIO is not defined."), since 0e970cec also broke the build.

The previous commit ad81f0545ef01ea651886dddac4bef6cec930092 ("Linux 
3.11-rc1") boots cleanly:

http://www.pwsan.com/omap/testlogs/test_v3.11-rc1/20130721020309/boot/5912osk/5912osk_log.txt

OMAP5912 OSK is an OMAP1 platform, and therefore non-DT.

Could you please put together a fix for this?


regards,

- Paul
