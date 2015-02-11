From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 10 Feb 2015 19:52:27 -0800
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: increase the number of maximum
 number of CPUs to 16
In-Reply-To: <1423626748-1277-1-git-send-email-tyler.baker@linaro.org>
References: <1423626748-1277-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1423626748-1277-2-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HiSilicon HiP04 has 16 CPUs. I propose we increase the maximum number of CPUs to 16 to avoid the following warning identified during automated boot testing [1].

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at ../arch/arm/kernel/devtree.c:144 arm_dt_init_cpu_maps+0x118/0x1e8()
DT /cpu 9 nodes greater than max cores 8, capping them
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.19.0-00528-gbdccc4edeb03 #1
Hardware name: Hisilicon HiP04 (Flattened Device Tree)
[] (unwind_backtrace) from [] (show_stack+0x10/0x14)
[] (show_stack) from [] (dump_stack+0x78/0x94)
[] (dump_stack) from [] (warn_slowpath_common+0x74/0xb0)
[] (warn_slowpath_common) from [] (warn_slowpath_fmt+0x30/0x40)
[] (warn_slowpath_fmt) from [] (arm_dt_init_cpu_maps+0x118/0x1e8)
[] (arm_dt_init_cpu_maps) from [] (setup_arch+0x638/0x9a0)
[] (setup_arch) from [] (start_kernel+0x8c/0x3b4)
[] (start_kernel) from [<10208074>] (0x10208074)
---[ end trace cb88537fdc8fa200 ]---

[1] http://storage.kernelci.org/mainline/v3.19-528-gbdccc4edeb03/arm-multi_v7_defconfig/lab-tbaker/boot-hip04-d01.html

Cc: Olof Johansson <olof@lixom.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e8a4c95..ad57306 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -86,7 +86,7 @@ CONFIG_PCI_MVEBU=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_SMP=y
-CONFIG_NR_CPUS=8
+CONFIG_NR_CPUS=16
 CONFIG_HIGHPTE=y
 CONFIG_CMA=y
 CONFIG_ARM_APPENDED_DTB=y
-- 
2.1.4
