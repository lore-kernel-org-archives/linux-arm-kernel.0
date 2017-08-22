From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 22 Aug 2017 11:15:21 +0100
Subject: [PATCH] soc/tegra: Register SoC device
In-Reply-To: <20170817144217.31346-1-thierry.reding@gmail.com>
References: <20170817144217.31346-1-thierry.reding@gmail.com>
Message-ID: <61dde661-313f-0b51-233b-ce957c514a55@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/08/17 15:42, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Move this code from arch/arm/mach-tegra and make it common among 32-bit
> and 64-bit Tegra SoCs. This is slightly complicated by the fact that on
> 32-bit Tegra, the SoC device is used as the parent for all devices that
> are instantiated from device tree.
> 

This seem to be in linux-next and causing the below splat on my platform
which is not Tegra :)

WARNING: .... at drivers/soc/tegra/fuse/tegra-apbmisc.c:48
tegra_get_chip_id+0x30/0x40
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Not tainted
4.13.0-rc6-next-20170822-00008-g52a8e57512ae #13
task: ffff8009768a0000 task.stack: ffff000008038000
PC is at tegra_get_chip_id+0x30/0x40
LR is at tegra_get_chip_id+0x30/0x40
 tegra_get_chip_id+0x30/0x40
 tegra_soc_device_register+0x68/0xd0
 tegra_init_soc+0x10/0x44
 do_one_initcall+0x38/0x120
 kernel_init_freeable+0x184/0x224
 kernel_init+0x10/0x100
 ret_from_fork+0x10/0x18

-- 
Regards,
Sudeep
