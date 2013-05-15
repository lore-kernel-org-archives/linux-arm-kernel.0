From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 15 May 2013 17:38:00 -0600
Subject: [PATCH 0/6] ARM: tegra114: add CPU hotplug support
In-Reply-To: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
Message-ID: <51941C58.9060002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2013 04:27 AM, Joseph Lo wrote:
> Tegra 114 is different with other Tegra SoC chips. It using ARM Cortex-A15
> as CPU core and a enhanced flow controller for CPU power control. So
> we need to skip some code that was for Contex-A9 and some other support
> code that was for other Tegra SoC chips. Then adding the proper power up
> and hot plug control for Tegra114.

This series mostly works OK, but I see one problem: I can't hotunplug
CPU0, which the commit descriptions and code changes imply I should be
able to do:

root at localhost:~# echo 0 > /sys/devices/system/cpu/cpu0/online
-bash: echo: write error: Operation not permitted
