From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 May 2015 11:58:32 -0700
Subject: [PATCH] phy: qcom-ufs: fix platform dependency
In-Reply-To: <4583047.eZev6xPGf6@wuerfel>
References: <4583047.eZev6xPGf6@wuerfel>
Message-ID: <555B87D8.2060406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/15 08:11, Arnd Bergmann wrote:
> The UFS PHY driver is written for the QCOM platform, but
> has an incorrect dependency pointing to the recently
> removed MSM platform, causing a warning whenever it
> gets selected:
>
> warning: (SCSI_UFS_QCOM) selects PHY_QCOM_UFS which has unmet direct dependencies (OF && ARCH_MSM)
>
> This fixes the dependency.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: af6f8fff446 ("ufs-qcom: Switch dependency to ARCH_QCOM")

Hm... I guess I should have combined the two patches into one. See [1]
for this exact patch from last month.

[1] https://lkml.org/lkml/2015/4/10/862

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
