From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 16 May 2013 17:53:39 +0800
Subject: [PATCH 0/6] ARM: tegra114: add CPU hotplug support
In-Reply-To: <51941C58.9060002@wwwdotorg.org>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <51941C58.9060002@wwwdotorg.org>
Message-ID: <1368698019.7403.10.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-05-16 at 07:38 +0800, Stephen Warren wrote:
> On 05/15/2013 04:27 AM, Joseph Lo wrote:
> > Tegra 114 is different with other Tegra SoC chips. It using ARM Cortex-A15
> > as CPU core and a enhanced flow controller for CPU power control. So
> > we need to skip some code that was for Contex-A9 and some other support
> > code that was for other Tegra SoC chips. Then adding the proper power up
> > and hot plug control for Tegra114.
> 
> This series mostly works OK, but I see one problem: I can't hotunplug
> CPU0, which the commit descriptions and code changes imply I should be
> able to do:
> 
> root at localhost:~# echo 0 > /sys/devices/system/cpu/cpu0/online
> -bash: echo: write error: Operation not permitted

I want to provide this function originally. But I found the
tegra_cpu_disable() was removed recently. It was replaced by the common
cpu_disable() function that didn't allow CPU0 to be un-plugged.

But I had verified the CPU0 is OK to be un-plugged on the older
linux-next branch that tegra_cpu_disable() watn't removed yet.

Do you want me to add them back to support this function for Tegra114?

Thanks,
Joseph
