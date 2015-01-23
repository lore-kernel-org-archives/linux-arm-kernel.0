From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 23 Jan 2015 17:10:55 +0100 (CET)
Subject: [PATCH v2 RESEND 2/8] irqchip: Supply new driver for STi based
 devices
In-Reply-To: <1421920133-7914-3-git-send-email-lee.jones@linaro.org>
References: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
 <1421920133-7914-3-git-send-email-lee.jones@linaro.org>
Message-ID: <alpine.DEB.2.11.1501231702280.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jan 2015, Lee Jones wrote:

> This driver is used to enable System Configuration Register controlled
> External, CTI (Core Sight), PMU (Performance Management), and PL310 L2
> Cache IRQs prior to use.

I'm wondering how this is related to irq_chip, but well, I don't mind
it being parked here.

Though I really cannot say anything about this DT translation
machinery for a single sysconfig register, other than it looks
completely overengineered to me.

The only technical comment I have is: shouldn't all the stuff except
the resume function be marked __init or is any of this required post
init?

Thanks,

	tglx
