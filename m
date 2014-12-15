From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 15 Dec 2014 22:45:35 +0100
Subject: [PATCH 1/5] genirq: Support mixing IRQF_NO_SUSPEND/IRQF_SUSPEND
 on shared irqs
In-Reply-To: <1418660152-17185-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
 <1418660152-17185-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <2845526.bsrmWSBaOD@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 15, 2014 05:15:48 PM Boris Brezillon wrote:
> The current implementation forbid sharing an irq line on devices that do
> not request the same behavior on suspend/resume (controlled via the
> IRQF_NO_SUSPEND/IRQF_FORCE_RESUME flags).

IRQF_NO_SUSPEND is practically only for timers and IPIs now.  Any other
usages are strongly discouraged.

> Add a flag (IRQF_SUSPEND_NOACTION) to specify that you don't want to be
> called in suspend mode, and that you already took care of disabling the
> interrupt on the device side.
> 
> The suspend_device_irq will now move actions specifying the
> IRQF_SUSPEND_NOACTION into a temporary list so that they won't be called
> when the interrupt is triggered, and resume_irq_actions restores the
> suspended actions into the active action list.

Why is the current way of handling wakeup interrupts not sufficient?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
