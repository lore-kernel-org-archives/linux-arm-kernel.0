From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Feb 2015 13:59:20 +0100
Subject: [PATCH 2/2] ARM: sunxi_defconfig: increase the number of maximum
 number of CPUs to 8
In-Reply-To: <1423626748-1277-3-git-send-email-tyler.baker@linaro.org>
References: <1423626748-1277-1-git-send-email-tyler.baker@linaro.org>
 <1423626748-1277-3-git-send-email-tyler.baker@linaro.org>
Message-ID: <20150216125920.GD25269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 07:52:28PM -0800, Tyler Baker wrote:
> The a80 optimus has 8 CPUs. I propose we increase the maximum number of CPUs to 8 to avoid the following warning identified during automated boot testing [1].
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at ../arch/arm/kernel/devtree.c:144 arm_dt_init_cpu_maps+0x110/0x1e0()
> DT /cpu 5 nodes greater than max cores 4, capping them
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.19.0-00528-gbdccc4edeb03 #1
> Hardware name: Allwinner sun9i Family
> [] (unwind_backtrace) from [] (show_stack+0x10/0x14)
> [] (show_stack) from [] (dump_stack+0x74/0x90)
> [] (dump_stack) from [] (warn_slowpath_common+0x70/0xac)
> [] (warn_slowpath_common) from [] (warn_slowpath_fmt+0x30/0x40)
> [] (warn_slowpath_fmt) from [] (arm_dt_init_cpu_maps+0x110/0x1e0)
> [] (arm_dt_init_cpu_maps) from [] (setup_arch+0x634/0x8d4)
> [] (setup_arch) from [] (start_kernel+0x88/0x3ac)
> [] (start_kernel) from [<20008074>] (0x20008074)
> ---[ end trace cb88537fdc8fa200 ]---
> 
> [1] http://storage.kernelci.org/mainline/v3.19-528-gbdccc4edeb03/arm-sunxi_defconfig/lab-tbaker/boot-sun9i-a80-optimus.html
> 
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150216/405acdd9/attachment.sig>
