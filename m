From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 12 Dec 2016 09:38:45 +0000
Subject: Tegra baseline test results for v4.8-rc6
In-Reply-To: <9eb90711-3de9-09dd-7751-fb8e3bfc91dd@nvidia.com>
References: <9eb90711-3de9-09dd-7751-fb8e3bfc91dd@nvidia.com>
Message-ID: <70a369f2-9177-cc2a-a8a4-0060a2fe5d22@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ignore this, wrong $subject ... still half asleep!

On 12/12/16 09:29, Jon Hunter wrote:
> Here are some basic Tegra test results for Linux v4.9-rc6.
> Logs and other details at:
> 
>     https://nvtb.github.io//linux/test_v4.9-rc6/20161121033104/
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
>     Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver
> 
> 
> vmlinux object size
> (delta in bytes from test_v4.9-rc5 (a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6)):
>    text     data      bss    total  kernel
>    -329     +592        0     +263  defconfig
>   +1307      +64        0    +1371  multi_v7_defconfig
>   +1143        0        0    +1143  tegra_defconfig
> 
> 
> Boot-time memory difference
> (delta in bytes from test_v4.9-rc5 (a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6))
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
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
nvpublic
