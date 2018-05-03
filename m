From: cpandya@codeaurora.org (Chintan Pandya)
Date: Thu, 3 May 2018 14:18:32 +0530
Subject: [PATCH 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
In-Reply-To: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
References: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
Message-ID: <1bc3ec9e-606b-e019-f870-ce4a2520cdbf@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/2/2018 1:24 PM, Ganesh Mahendran wrote:
> Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
> enables Speculative Page Fault handler.
> 
> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
> ---
> This patch is on top of Laurent's v10 spf
> ---
>   arch/arm64/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eb2cf49..cd583a9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -144,6 +144,7 @@ config ARM64
>   	select SPARSE_IRQ
>   	select SYSCTL_EXCEPTION_TRACE
>   	select THREAD_INFO_IN_TASK
> +	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT if SMP
>   	help
>   	  ARM 64-bit (AArch64) Linux support.
>   
> 

You may also consider re-ordering of patches in next version. Generally,
config enablement assumes effectiveness of that config.

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
