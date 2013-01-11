From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 11 Jan 2013 10:42:40 -0500
Subject: [PATCH 6/6] ARM: virt: hide CONFIG_ARM_VIRT_EXT from user
In-Reply-To: <1357918457-20469-7-git-send-email-will.deacon@arm.com>
References: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
 <1357918457-20469-7-git-send-email-will.deacon@arm.com>
Message-ID: <50F032F0.3070906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 01/11/2013 10:34 AM, Will Deacon wrote:
> ARM_VIRT_EXT is a property of CPU_V7, but does not adversely affect
> other CPUs that can be built into the same kernel image (i.e. ARMv6+).
> 
> This patch defaults ARM_VIRT_EXT to y if CPU_V7, allowing hypervisors
> such as KVM to make better use of the option and being able to rely
> on hyp-mode boot support.

[...]

> @@ -640,11 +641,6 @@ config ARM_VIRT_EXT
>  	  use of this feature.  Refer to Documentation/arm/Booting for
>  	  details.
>  
> -	  It is safe to enable this option even if the kernel may not be
> -	  booted in HYP mode, may not have support for the
> -	  virtualization extensions, or may be booted with a
> -	  non-compliant bootloader.

Why take this out?

[...]

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
