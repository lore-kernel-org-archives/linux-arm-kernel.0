From: davidb@codeaurora.org (David Brown)
Date: Sat, 7 Jan 2012 11:08:52 -0800
Subject: MSM's mach/system.h
In-Reply-To: <20120107105950.GD13857@n2100.arm.linux.org.uk>
References: <20120107105950.GD13857@n2100.arm.linux.org.uk>
Message-ID: <20120107190851.GB19216@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2012 at 10:59:51AM +0000, Russell King - ARM Linux wrote:
> Guys,
> 
> MSM's mach/system.h is now almost empty, except for this:
> 
> extern void (*msm_hw_reset_hook)(void);
> 
> Grepping around for this, I find only one place where it's called, and
> nowhere it's set:
> 
> $ grep -r msm_hw_reset_hook arch/arm/*msm* drivers/
> arch/arm/mach-msm/include/mach/system.h:extern void (*msm_hw_reset_hook)(void);
> arch/arm/mach-msm/smd.c:void (*msm_hw_reset_hook)(void);
> arch/arm/mach-msm/smd.c:    if (msm_hw_reset_hook)
> arch/arm/mach-msm/smd.c:            msm_hw_reset_hook();

Also somewhat disturbing that the hook is declared again in the smd.c
driver, so the declaration in mach/system.h isn't really even used.

> As we've virtually eliminated the mach/system.h include (the only
> remaining ones apart from this are the three unconverted platforms for
> the restart changes), can this declaration move to somewhere else, or
> can this read-only hook be removed?

As far as I can tell, nothing even uses it in the main Android tree.
It looks like it got copied from another arch, never filled in, and
never used for anything.

It appears that plat-s5p, and mach-s3c2410 also have an unused hook.

I can make a patch, but I'm not sure what it should be based on.  Or,
feel free to remove it.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
