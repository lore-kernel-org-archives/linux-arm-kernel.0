From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Nov 2015 17:10:14 -0800
Subject: [PATCH] ARM: qcom: select ARM_CPU_SUSPEND for power management
In-Reply-To: <5497046.7sx8fEMiNf@wuerfel>
References: <5497046.7sx8fEMiNf@wuerfel>
Message-ID: <20151125011014.GA8328@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24, Arnd Bergmann wrote:
> The qcom spm driver uses cpu_resume_arm(), which is not included
> in the kernel in all configurations:
> 
> drivers/built-in.o: In function `qcom_cpu_spc':
> :(.text+0xbc022): undefined reference to `cpu_suspend'
> drivers/built-in.o: In function `qcom_cpuidle_init':
> :(.init.text+0x610c): undefined reference to `cpu_resume_arm'
> 
> This adds a 'select' Kconfig statement to ensure it's always
> enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
