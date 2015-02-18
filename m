From: venkappa.m@samsung.com (Venkappa Mala)
Date: Wed, 18 Feb 2015 12:12:22 +0000 (UTC)
Subject: [PATCH v10 4/6] ARM: add vdso user-space code
References: <1411413485-7675-1-git-send-email-nathan_lynch@mentor.com>
 <1411413485-7675-5-git-send-email-nathan_lynch@mentor.com>
 <loom.20150213T053547-381@post.gmane.org>
 <20150213105447.GB3508@e104818-lin.cambridge.arm.com>
 <loom.20150213T124417-857@post.gmane.org> <20150213141425.GA4713@localhost>
 <loom.20150213T153239-809@post.gmane.org>
 <20150213153253.GA23801@e104818-lin.cambridge.arm.com>
Message-ID: <loom.20150218T122348-60@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas <at> arm.com> writes:


> I highly doubt you are having a problem with [1] since you mentioned
> Cortex-A7 which falls under [2]. If you have a _processor_
> implementation with generic timers but no Hyp, as per the ARMv7 ARM 
the
> CNTVCT == CNTPCT, otherwise it is a CPU bug.
> 
> What you actually have is [2] but without code to initialise the Hyp
> mode. If your kernel is running non-secure, sane Hyp registers
> initialisation is mandatory even when the kernel does not boot in Hyp.
yes, cortexA7 is falling under [2]. i.e. my mistake. Thanks for the 
correction.

> Even for the kernel, this should be the case unless
> "arm,cpu-registers-not-fw-configured" is passed in the DT (this was
> really only meant as workaround for broken firmware; I think
> Documentation/arm/Booting needs to be updated with the state of the
> generic timers on entry).
It will be good and it helps a lot if it updates.
 
> IIRC there were some discussions about Linux booting in secure mode on
> ARMv7 with no firmware to initialise the Hyp registers. If that's the
> case for you, we could restart that discussion and try to initialise
> CNTVOFF in the kernel running in _secure_ mode (possibly with some CPU
> notifiers in the generic timer code).
My test environment is like CNTVOFF initialization is not taken care in 
the firmware, HYP mode is disabled and kernel is booted with Secure SVC 
PL1 mode. As you have mentioned about restarting the thread, perhaps, it 
will be good to have a discussion in the following  thread rather than 
restarting the thread.
arm: Handle starting up in secure mode
https://lkml.org/lkml/2014/9/16/552

May I know your opinion about this one?

BR,
Venkappa
