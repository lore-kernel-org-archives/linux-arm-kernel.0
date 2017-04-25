From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 25 Apr 2017 13:14:56 +0100
Subject: Tegra baseline test results for v4.11-rc6
In-Reply-To: <7ef3c6bd-0f47-4277-eff5-940af68c858f@nvidia.com>
References: <7ef3c6bd-0f47-4277-eff5-940af68c858f@nvidia.com>
Message-ID: <52cc6e7c-4643-8d53-6749-6cd64cb23ff5@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25/04/17 13:03, Jon Hunter wrote:
> Here are some basic Tegra test results for Linux v4.11-rc6.
> Logs and other details at:
> 
>     https://nvtb.github.io//linux/test_v4.11-rc6/20170411053103/
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
>     Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver
> 
> PM: System suspend: tegra_defconfig:
>     FAIL: ( 1/ 5): tegra124-nyan-big
>     Pass: ( 4/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra20-trimslice, tegra30-beaver

The above suspend failure for nyan-big bisected to commit ce612879ddc7
("mm: move pcp and lru-pcp draining into single wq"). There have been
other reports of this breaking suspend [0] and has since been fixed [1]
for v4.11-rc7.

Interestingly this only was causing problems for tegra with XHCI enabled
(in tegra_defconfig). I am seeing some random usb resets during resume
with XHCI and so if anyone sees any such problems let me know.

Cheers
Jon

[0] http://marc.info/?l=linux-kernel&m=149254544031358&w=2
[1] http://marc.info/?l=linux-kernel&m=149258864408467&w=2

-- 
nvpublic
