From: digetx@gmail.com (Dmitry Osipenko)
Date: Mon, 6 Nov 2017 20:44:59 +0300
Subject: Tegra baseline test results for v4.14-rc8
In-Reply-To: <8bed4ae2-db37-5bf9-5099-e8b241ad4b1b@nvidia.com>
References: <8bed4ae2-db37-5bf9-5099-e8b241ad4b1b@nvidia.com>
Message-ID: <7d041081-f60b-2eb3-f7e2-fa7d469f50f6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.11.2017 15:36, Jon Hunter wrote:
> Here are some basic Tegra test results for Linux v4.14-rc8.
> Logs and other details at:
> 
>     https://nvtb.github.io//linux/test_v4.14-rc8/20171105133104/
> 

The "timeout waiting for phy to stabilize" still persists on Trimslice and I've
seen it occasionally after the "Fix phy suspend for UDC" patch been applied, but
not on every boot as before the patch. It looks to me that increasing timeout
value completely fixes it, maybe you could check if increasing timeout helps on
Trimslice?

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
>     Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver
> 
> 
> vmlinux object size
> (delta in bytes from test_v4.14-rc7 (0b07194bb55ed836c2cc7c22e866b87a14681984)):
>    text     data      bss    total  kernel
>    -328     +376        0      +48  defconfig
>   +6652      +64        0    +6716  multi_v7_defconfig
>   +6852    +4096        0   +10948  tegra_defconfig
> 
> 
> Boot-time memory difference
> (delta in bytes from test_v4.14-rc7 (0b07194bb55ed836c2cc7c22e866b87a14681984))
>     avail    rsrvd     high    freed                board              kconfig                  dtb
>         .        .        .        .      qemu-vexpress64            defconfig           __internal
>         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
>         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
>         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
>         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
>         .        .        .        .    tegra124-nyan-big   multi_v7_defconfig    tegra124-nyan-big
>         .        .        .        .    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
>         .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
>         .        .        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
>         .        .        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
>         .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
>         .        .        .        .       tegra210-smaug            defconfig       tegra210-smaug
>         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
>         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
> --
> nvpublic
