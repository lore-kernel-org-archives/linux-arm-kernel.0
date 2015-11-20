From: agross@codeaurora.org (Andy Gross)
Date: Fri, 20 Nov 2015 07:27:56 -0600
Subject: [PATCH v2] soc: qcom: enable smsm/smp2p modular build
In-Reply-To: <4169906.YsYnNqcaru@wuerfel>
References: <4169906.YsYnNqcaru@wuerfel>
Message-ID: <20151120132756.GA20599@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 11:32:21AM +0100, Arnd Bergmann wrote:
> The newly added smp2p and smsm drivers cannot be loadable modules
> but depend on smem, which can be, and that causes a link error:
> 
> drivers/built-in.o: In function `qcom_smp2p_intr':
> :(.text+0xa6e68): undefined reference to `qcom_smem_get'
> drivers/built-in.o: In function `qcom_smp2p_probe':
> :(.text+0xa7320): undefined reference to `qcom_smem_alloc'
> :(.text+0xa736c): undefined reference to `qcom_smem_get'
> drivers/built-in.o: In function `qcom_smsm_probe':
> :(.text+0xa7b34): undefined reference to `qcom_smem_get'
> 
> This marks all the drivers as 'tristate' to make the Kconfig
> dependency resolution work properly.

Nice catch.  I'll add this on top of those.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
