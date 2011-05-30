From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 May 2011 23:21:07 +0100
Subject: [PATCH 3.0-rc1] OMAP: fix compilation error
In-Reply-To: <201105302344.01530.jkrzyszt@tis.icnet.pl>
References: <201105302344.01530.jkrzyszt@tis.icnet.pl>
Message-ID: <20110530222107.GA21753@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 11:44:01PM +0200, Janusz Krzysztofik wrote:
> Include <linux/platform_device.h> from 
> arch/arm/plat-omap/include/plat/flash.h, otherwise compilation may break 
> with:
> 
> In file included from arch/arm/mach-omap1/flash.c:15:
> arch/arm/plat-omap/include/plat/flash.h:14: warning: 'struct platform_device' declared inside parameter list
> arch/arm/plat-omap/include/plat/flash.h:14: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/arm/mach-omap1/flash.c:16: warning: 'struct platform_device' declared inside parameter list
> arch/arm/mach-omap1/flash.c:17: error: conflicting types for 'omap1_set_vpp'
> arch/arm/plat-omap/include/plat/flash.h:14: error: previous declaration of 'omap1_set_vpp' was here

Just forward-declare the struct by adding:

struct platform_device;

in this header; there's no need to add to the complexities of header file
inclusion...
