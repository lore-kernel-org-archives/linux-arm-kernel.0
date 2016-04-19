From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 19 Apr 2016 10:26:51 +0100
Subject: Tegra baseline test results for v4.6-rc1
In-Reply-To: <5715F45E.3080305@nvidia.com>
References: <5715F45E.3080305@nvidia.com>
Message-ID: <5715F9DB.5040403@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 19/04/16 10:03, Jon Hunter wrote:
> Here are some basic Tegra test results for Linux v4.6-rc1.
> Logs and other details at:
> 
>     https://nvtb.github.io//linux/test_v4.6-rc1/20160330013102/
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
>     FAIL: ( 1/ 4): tegra124-jetson-tk1

This failure occurs intermittently and was caused by enabling the UHS-I
modes for Tegra124. To workaround this we have disabled these mode for
now [0].

Jon

[0] http://www.spinics.net/lists/linux-mmc/msg36245.html
