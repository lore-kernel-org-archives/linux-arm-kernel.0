From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 15 Jan 2012 13:07:36 +0100
Subject: [PATCH] ARM: Fix regression caused by ARCH_NR_GPIOS removal
In-Reply-To: <20120114233626.GA11769@n2100.arm.linux.org.uk>
References: <201201150033.25885.rjw@sisk.pl>
 <20120114233626.GA11769@n2100.arm.linux.org.uk>
Message-ID: <201201151307.36813.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, January 15, 2012, Russell King - ARM Linux wrote:
> On Sun, Jan 15, 2012 at 12:33:25AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Commit 3dea19e826da3dd43b3dc308aca299c0b7263c6b (ARM: 7244/1:
> > mach-shmobile: Use CONFIG_ARCH_NR_GPIO) removed ARCH_NR_GPIOS
> > and introduced ARCH_NR_GPIO instead without changing the users
> > of that symbol.  As a result, the kernels including that commit
> > don't boot on my test-bed Mackerel board.
> > 
> > Fix the problem by defining ARCH_NR_GPIOS again.
> 
> I'm aware of it, and have:
> 
> commit ca95023e7521729d3ace6fb3b9c53281c510a18c
> Author: Stephen Warren <swarren@nvidia.com>
> Date:   Thu Jan 5 21:36:27 2012 +0100
> 
>     ARM: 7271/1: Fix typo in conversion of ARCH_NR_GPIOS to Kconfig
>     
>     Commit 44986ab "ARM: 7240/1: Make ARCH_NR_GPIO a Kconfig variable"
>     spelled ARCH_NR_GPIOS as ARCH_NR_GPIO, hence making the change
>     ineffective. This change fixes that.
>     
>     Signed-off-by: Stephen Warren <swarren@nvidia.com>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> already queued up.

Cool, thanks!

Rafael
