From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 06 Jul 2010 10:06:08 -0700
Subject: [PATCH v2] msm: gpio: Add set_wake support to msm7200a-gpio's
	irq_chip.
In-Reply-To: <4C336020.3090206@codeaurora.org>
References: <1278185128-29161-1-git-send-email-gbean@codeaurora.org>
	<1278434857.27490.2.camel@c-dwalke-linux.qualcomm.com>
	<4C336020.3090206@codeaurora.org>
Message-ID: <1278435968.27490.5.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-06 at 09:56 -0700, Greg Bean wrote:
> >> Add power-management and irq_chip hooks to allow configuration
> >> of msm-gpio irq lines as wakeup sources.
> >
> > What level of correlation is there between power management and the wake
> > up hooks? Just irq_masks ?
> 
> When the system sleeps, gpio-based irqs which are not configured as wake-up 
> sources are disabled in the controller hardware to prevent latching and 
> unwanted wakeups.

So you could make these two patches? It seems like they're relatively
distinct other than the one fairly ordered dependency you mention above.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
