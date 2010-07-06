From: gbean@codeaurora.org (Greg Bean)
Date: Tue, 06 Jul 2010 09:56:00 -0700
Subject: [PATCH v2] msm: gpio: Add set_wake support to msm7200a-gpio's
	irq_chip.
In-Reply-To: <1278434857.27490.2.camel@c-dwalke-linux.qualcomm.com>
References: <1278185128-29161-1-git-send-email-gbean@codeaurora.org>
	<1278434857.27490.2.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <4C336020.3090206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Add power-management and irq_chip hooks to allow configuration
>> of msm-gpio irq lines as wakeup sources.
>
> What level of correlation is there between power management and the wake
> up hooks? Just irq_masks ?

When the system sleeps, gpio-based irqs which are not configured as wake-up 
sources are disabled in the controller hardware to prevent latching and 
unwanted wakeups.

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
