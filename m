From: khilman@ti.com (Kevin Hilman)
Date: Tue, 04 Jan 2011 16:37:47 -0800
Subject: [PATCH 0/5] omap2plus: Trivial build break fixes
In-Reply-To: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Tue, 4 Jan 2011 23:56:11 +0530")
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <8762u4423o.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> These are trivial build fixes which I found while doing some 
> testing 'omap-for-linus' branch.
>
> The series is generated against the linux-omap 'omap-for-linus' branch
> and boot tested on OMAP4430 SDP and OMAP3630 ZOOM.

Minor nit in your git-send-email config.  

Can you add the following to your ~/.gitconfig, or update to newer git
where this is now the default:

[sendemail]
	chainreplyto = false

This will make all patches a reply to PATCH 0 instead of to the previous
patch.

Thanks,

Kevin

>
>
> The following changes since commit dc69d1af9e8d9cbbabff88bb35a6782187a22229:
>   Ben Gamari (1):
>         omap2: Make OMAP2PLUS select OMAP_DM_TIMER
>
>
> Santosh Shilimkar (5):
>       omap2plus: clockdomain: Trivial fix for build break because of clktrctrl_mask
>       omap2plus: prm: Trvial build break fix for undefined reference to 'omap2_prm_read_mod_reg'
>       omap2plus: voltage: Trivial warning fix 'no return statement'
>       omap2plus: voltage: Trivial linking fix 'undefined reference'
>       omap2plus: voltage: Trivial linking fix for 'EINVAL' undeclared
>
>  arch/arm/mach-omap2/Makefile              |    2 +-
>  arch/arm/mach-omap2/clockdomain.h         |    2 +-
>  arch/arm/mach-omap2/prm2xxx_3xxx.h        |   45 ++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/voltage.h |   17 ++++++++--
>  4 files changed, 59 insertions(+), 7 deletions(-)
