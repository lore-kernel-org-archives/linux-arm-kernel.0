From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 22 Feb 2016 10:23:46 +0000
Subject: Tegra baseline test results for v4.5-rc4
In-Reply-To: <56CADFE6.8040605@nvidia.com>
References: <56CADFE6.8040605@nvidia.com>
Message-ID: <56CAE1B2.20402@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 22/02/16 10:16, Jon Hunter wrote:
> Here are some basic Tegra test results for Linux v4.5-rc4.
> Logs and other details at:
> 
>     https://nvtb.github.io//linux/test_v4.5-rc4/20160214133102/
> 
> 
> Test summary
> ------------
> 
> Build: zImage:
>     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig
> 
> Build: Image:
>     Pass: ( 1/ 1): defconfig
> 
> Boot to userspace: defconfig:
>     Pass: ( 3/ 3): qemu-vexpress64, tegra132-norrin,
> 		   tegra210-p2371-0000
> 
> Boot to userspace: multi_v7_defconfig:
>     Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra20-trimslice, tegra30-beaver
> 
> Boot to userspace: tegra_defconfig:
>     Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra20-trimslice, tegra30-beaver
> 
> PM: System suspend: multi_v7_defconfig:
>     FAIL: ( 1/ 4): tegra114-dalmore-a04
>     Pass: ( 3/ 4): tegra124-jetson-tk1, tegra20-trimslice,
> 		   tegra30-beaver
> 
> PM: System suspend: tegra_defconfig:
>     FAIL: ( 1/ 4): tegra114-dalmore-a04
>     Pass: ( 3/ 4): tegra124-jetson-tk1, tegra20-trimslice,
> 		   tegra30-beaver

Between 4.5-rc3 and 4.5-rc4 a SD card has been inserted into the
Tegra114-dalmore and with the SD card present, system suspend is now
failing. After performing more testing, it appears that system suspend
on the Tegra114-dalmore (with an SD card present) has been broken
between v4.4 and v4.5-rc1 following some changes to enable UHS-I modes
for Tegra. A patch is in the works to disable these modes for Tegra114
[0] and allows suspend to work again.

Jon

[0] http://marc.info/?l=linux-tegra&m=145580693311178&w=2
