From: davidb@codeaurora.org (David Brown)
Date: Tue, 13 Dec 2011 12:11:37 -0800
Subject: [PATCH v4 2/5] ARM: SMP: Refactor Kconfig to be more maintainable
In-Reply-To: <1323798993-8727-3-git-send-email-dave.martin@linaro.org>
References: <1323798993-8727-1-git-send-email-dave.martin@linaro.org>
 <1323798993-8727-3-git-send-email-dave.martin@linaro.org>
Message-ID: <20111213201137.GA31437@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 05:56:30PM +0000, Dave Martin wrote:
> Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> bothersome to maintain and likely to lead to merge conflicts.

> diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
> index ebde97f..e6beaff 100644
> --- a/arch/arm/mach-msm/Kconfig
> +++ b/arch/arm/mach-msm/Kconfig
> @@ -67,6 +67,7 @@ config MSM_SOC_REV_A
>  	bool
>  config  ARCH_MSM_SCORPIONMP
>  	bool
> +	select HAVE_SMP
>  
>  config  ARCH_MSM_ARM11
>  	bool

The ARCH_MSM_SCORPIONMP config's only purpose was to enable SMP higher
up.  We might as well eliminate ARCH_MSM_SCORPIONMP entirely, and just
select HAVE_SMP in ARCH_MSM8X60 and ARCH_MSM8960.

Also, be sure to run ./scripts/get_maintainer.pl on your patch so that
the proper people get addressed by the message.  Otherwise, people
might miss patches.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
