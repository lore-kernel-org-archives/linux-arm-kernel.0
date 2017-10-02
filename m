From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 2 Oct 2017 10:39:37 +0100
Subject: Tegra baseline test results for v4.14-rc3
In-Reply-To: <39a8ab29-1eda-674a-6f55-d4cf95eff223@nvidia.com>
References: <39a8ab29-1eda-674a-6f55-d4cf95eff223@nvidia.com>
Message-ID: <c874cf3e-0f59-6922-fa68-40223cca7c13@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/10/17 10:34, Jon Hunter wrote:
> Here are some basic Tegra test results for Linux v4.14-rc3.
> Logs and other details at:
> 
>     https://nvtb.github.io//linux/test_v4.14-rc3/20171001153104/
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
>     Pass: ( 4/ 4): qemu-vexpress64, tegra132-norrin,
> 		   tegra210-p2371-0000, tegra210-smaug
> 
> Boot to userspace: multi_v7_defconfig:
>     Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver
> 
> Boot to userspace: tegra_defconfig:
>     Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver
> 
> PM: System suspend: multi_v7_defconfig:
>     FAIL: ( 3/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra30-beaver
>     Pass: ( 2/ 5): tegra124-nyan-big, tegra20-trimslice
> 
> PM: System suspend: tegra_defconfig:
>     FAIL: ( 3/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra30-beaver
>     Pass: ( 2/ 5): tegra124-nyan-big, tegra20-trimslice

The cause of the above suspend failure has been identified and a
candidate for fixing this is under review [0].

Cheers
Jon

[0] https://www.spinics.net/lists/linux-usb/msg161139.html

-- 
nvpublic
