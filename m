From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Aug 2016 14:43:14 +0200
Subject: [PATCH] dmaengine: mv_xor: Add support for IO (PCIe) src/dst areas
In-Reply-To: <b8c09619-22a5-a677-8841-9760c275a618@denx.de>
References: <201608241240.aEXnCS9C%fengguang.wu@intel.com>
 <b8c09619-22a5-a677-8841-9760c275a618@denx.de>
Message-ID: <20160824144314.18928e13@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 24 Aug 2016 10:23:02 +0200, Stefan Roese wrote:

> > All errors (new ones prefixed by >>):
> > 
> >    drivers/built-in.o: In function `set_param_ifnum':  
> >>> ipmi_poweroff.c:(.text+0x10157c): undefined reference to `mvebu_mbus_get_io_win_info'  
> >    drivers/built-in.o: In function `mv_xor_add_io_win':
> >    mv_xor.c:(.text+0x11039e): undefined reference to `mvebu_mbus_get_io_win_info'  
> 
> Does it really make sense to compile this driver for all archs?
> Or should I send a v2 of this patch that removes COMPILE_TEST for
> this driver from Kconfig so that its only compiled for the
> target platforms?

I'm not sure what's the exact policy, but I believe kernel maintainers
like when the compilation coverage is as wide as possible. The MBus
driver could provide some stub functions when not enabled? I don't know
if it's worth it, since indeed mv_xor is only ever going to be used on
ARM.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
