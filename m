From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Wed, 17 Jan 2018 10:58:23 +0800
Subject: [PATCH v3 06/20] arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN
In-Reply-To: <1512563739-25239-7-git-send-email-will.deacon@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
 <1512563739-25239-7-git-send-email-will.deacon@arm.com>
Message-ID: <cddbd896-2a23-1aa2-bbd8-3bc7cf5367e2@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2017/12/6 20:35, Will Deacon wrote:
>  config ARM64_SW_TTBR0_PAN
>  	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
> -	depends on BROKEN       # Temporary while switch_mm is reworked
>  	help
>  	  Enabling this option prevents the kernel from accessing
>  	  user-space memory directly by pointing TTBR0_EL1 to a reserved

I have a question not related to this patch itself, but to ARM64_SW_TTBR0_PAN:

What does ARM64_SW_TTBR0_PAN used for? I means is hardware support PAN, do we
still need SW_TTBR0_PAN?

And if the hardware do not support PAN, is SW_TTBR0_PAN is *must* option? or
there maybe a security risk?

Thanks
Yisheng Xie
