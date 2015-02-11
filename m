From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 10 Feb 2015 19:52:26 -0800
Subject: [PATCH 0/2] ARM: multi_v7_defconfig,
 sunxi_defconfig: increase maximum number of CPUs  
Message-ID: <1423626748-1277-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have recently been reviewing the kernel warnings generated from the kernelci.org boot farm, and have discovered that the HiP04 and a80-optimus boards have more CPUs then the maximum allowed in a few of the ARM defconfigs. This series fixes those warnings by increasing the maximum number of CPUs. I went ahead and boot tested these patches on various boards [1] to insure there are no regressions introduced when increasing the number of CPUs. 

Any comments would be appreciated. Perhaps we may want to increase these limits further?

Thanks,

[1] http://kernelci.org/boot/all/job/tbaker/kernel/v3.19-rc4-845-g9f29e39a74a2/ 

Tyler Baker (2):
  ARM: multi_v7_defconfig: increase the number of maximum number of CPUs to
    16
  ARM: sunxi_defconfig: increase the number of maximum number of CPUs to 8

 arch/arm/configs/multi_v7_defconfig | 2 +-
 arch/arm/configs/sunxi_defconfig    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.1.4
