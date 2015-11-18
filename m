From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 18 Nov 2015 15:28:46 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <5236157.AUJjCLOEeJ@wuerfel>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <HK2PR06MB0561B7675F17A81B54A65CA28A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511172129060.22569@knanqh.ubzr>
 <5236157.AUJjCLOEeJ@wuerfel>
Message-ID: <HK2PR06MB0561DABA3F9198803825E80F8A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> [Adding Uwe and Maxime to Cc]
> 
> I believe Uwe has been running XIP_KERNEL on efm32 for a while now,
> but he also mentioned that he needed some extra hacks in the linker
> script and elsewhere to get it to work.


Yes, Maxime got the XIP fix for scripts/link-vmlinux.sh into the kernel ([PATCH v6 01/15] scripts: link-vmlinux: Don't pass page offset to kallsyms if XIP Kernel), which of course made one less file I have to patch.


> It would be good to coordinate this, he may have found additional
> problems, or he can maybe help test the new approach on his hardware.

The part I'm using (RZ/A1H) is a Cortex A9 and the EFM32 is a Cortex M3, so we'd be able to test both MMU and non-MMU XIP systems.


Chris
