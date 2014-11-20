From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Thu, 20 Nov 2014 01:25:18 +0000
Subject: 48-bit VA support in the SMMU
In-Reply-To: <deb48cfb93d94515b6531be02f697e04@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <deb48cfb93d94515b6531be02f697e04@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <decb25f05ca84d439e071f6ad8cf0086@BN3PR0301MB1219.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,
What specific tweaks are required in the arm-smmu driver? I thought that the upstream arm-smmu (3.18-rc3) driver does support 48 bit input address (depended on the ARM64 kernel 48 bit support). Isn't this dependent on the VA_BITS?  

Regards
Varun

-----Original Message-----
From: Yoder Stuart-B08248 
Sent: Thursday, November 20, 2014 5:00 AM
To: Will Deacon
Cc: linux-arm-kernel at lists.infradead.org; Sethi Varun-B16395; Christoffer Dall
Subject: 48-bit VA support in the SMMU

Hi Will,

Regarding 48-bit support at the SMMU, this patch is currently in the kernel:

commit 04f905a9569ca2b6964a35563f135fabbb2470bc
Author: Christoffer Dall <christoffer.dall@linaro.org>
Date:   Fri Oct 10 11:14:30 2014 +0100

    arm64: Allow 48-bits VA space without ARM_SMMU

    Now when KVM has been reworked to support 48-bits host VA space, we can
    allow systems to be configured with this option.  However, the ARM SMMU
    driver also needs to be tweaked for 48-bit support so only allow the
    config option to be set when not including support for theSMMU.

    Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index ac9afde..b8053be 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -232,7 +232,7 @@ config ARM64_VA_BITS_42

 config ARM64_VA_BITS_48
        bool "48-bit"
-       depends on BROKEN
+       depends on !ARM_SMMU

 endchoice


Do you know the status of any work to remove this limitation?

Thanks,
Stuart
