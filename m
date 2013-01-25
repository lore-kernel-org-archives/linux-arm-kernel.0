From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jan 2013 10:40:48 -0800
Subject: [PATCH v2] ARM: SAMSUNG: Gracefully exit on suspend failure
In-Reply-To: <1358515116-7280-1-git-send-email-a.kesavan@samsung.com>
References: <1357729952-14881-1-git-send-email-a.kesavan@samsung.com>
 <1358515116-7280-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <014101cdfb2b$7f9ec710$7edc5530$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> 
> As per the Exynos5250 User Manual:
> When there are pending interrupt events, WFI/WFE instruction are
> ignored. To cancel the power-down sequence follow these steps:
> 1) Disable system power-down using CENTRAL_SEQ_CONFIGURATION
> register
> 2) Clear WAKEUP_STAT register
> 3) Enable interrupt service routine for CPU
> 
> Code for early wakeup for exynos already exists. Remove the panic
> on suspend failure, clear the wakeup state register and return 1
> from cpu_suspend to indicate a failed suspend (to a user daemon).
> 
> Older Samsung SoCs have similar panics and I have removed them all.
> Haven't touched the S3C2410 sleep code.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
Looks OK to me, applied.

Thanks.

- Kukjin
