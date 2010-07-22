From: smuckle@codeaurora.org (smuckle at codeaurora.org)
Date: Thu, 22 Jul 2010 12:33:08 -0700 (PDT)
Subject: hotplug and init section
Message-ID: <989bc3c9f8d8ce1d51c480a0dbdce07e.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working on hotplug support. It looks like currently only mach-realview
supports this on ARM, and it does not fully power down the core.  The core
just goes into wfi. If we fully power down the core being hot-removed, we
need to rerun the processor init, enable mmu, turn on mmu, etc when it is
brought back up.

This code is currently all put in the .init section. Changing things so
that the code required for bringing up secondary cores is still present
after init looks to be a fairly big change. As such I wanted to see if
anyone had thoughts here before I start hacking up head.S, the linker
script, etc.

thanks,
Steve

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
