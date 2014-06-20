From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 16:39:27 -0400
Subject: [PATCH] ARM: mvebu: select ARM_CPU_SUSPEND for Marvell EBU v7
 platforms
In-Reply-To: <1402488397-31381-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1402488397-31381-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140620203927.GJ21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 02:06:37PM +0200, Thomas Petazzoni wrote:
> On Marvell Armada platforms, the PMSU (Power Management Service Unit)
> controls a number of power management related activities, needed for
> things like suspend/resume, CPU hotplug, cpuidle or even simply SMP.
> 
> Since cpuidle support was added for Armada XP, the pmsu.c file in
> arch/arm/mach-mvebu/ calls the cpu_suspend() and cpu_resume() ARM
> functions, which are only available when
> CONFIG_ARM_CPU_SUSPEND=y. Therefore, configurations that have
> CONFIG_ARM_CPU_SUSPEND disabled due to PM_SLEEP being disabled no
> longer build properly, due to undefined references to cpu_suspend()
> and cpu_resume().
> 
> To fix this, this patch simply ensures CONFIG_ARM_CPU_SUSPEND is
> always enabled for Marvell EBU v7 platforms. Doing things in a more
> fine-grained way would require a lot of #ifdef-ery in pmsu.c to
> isolate the parts that use cpu_suspend()/cpu_resume(), and those parts
> would anyway have been needed as soon as either one of suspend/resume,
> CPU hotplug or cpuidle was enabled.
> 
> Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Jason, this patch is against the mvebu/soc branch, and should be
> pushed to 3.16, where the problem was introduced.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/fixes with Ezequiel's Ack.

thx,

Jason.
