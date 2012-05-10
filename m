From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 May 2012 16:04:20 -0600 (MDT)
Subject: [PATCH-V7 0/3] ARM: OMAP: Make OMAP clocksource source selection
 runtime
In-Reply-To: <2430095.tlzScq1o2g@acer>
References: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
 <2430095.tlzScq1o2g@acer>
Message-ID: <alpine.DEB.2.00.1205101603350.32719@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Janusz,

On Thu, 10 May 2012, Janusz Krzysztofik wrote:

> Tried to test this branch, merged into 3.4-rc6, and with my Amstrad 
> Delta fixes applied, using my custom Amstrad Delta config, but initially 
> failed because an unrelated issue rised to the surface:
> 
> |   LD      .tmp_vmlinux1
> | arch/arm/mach-omap1/built-in.o: In function `omap1_usb_init':
> | lcd_dma.c:(.init.text+0x1420): undefined reference to `ocpi_enable'
> | make: *** [.tmp_vmlinux1] Error 1
> 
> Apparently introduced with commit 
> d3645d39ad0ed9f09535065676ea0ba114f93cdf, "ARM: OMAP1: OHCI: use 
> platform_data fn ptr to enable OCPI bus", looks like one or more symbols 
> exported by the not linked in arch/arm/mach-omap1/ocpi.o may be missing 
> for non-OMAP16xx configs.

Thanks for the report, I'll send a fix.


- Paul
