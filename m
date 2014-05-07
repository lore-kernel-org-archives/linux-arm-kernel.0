From: larry.bassel@linaro.org (Larry Bassel)
Date: Wed, 7 May 2014 14:35:51 -0700
Subject: [PATCH v2 2/2] arm64: enable context tracking
In-Reply-To: <20140507101709.GE18456@arm.com>
References: <1399419149-26685-1-git-send-email-larry.bassel@linaro.org>
 <1399419149-26685-3-git-send-email-larry.bassel@linaro.org>
 <20140507101709.GE18456@arm.com>
Message-ID: <20140507213550.GA10142@ubuette>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07 May 14 11:17, Will Deacon wrote:
> On Wed, May 07, 2014 at 12:32:29AM +0100, Larry Bassel wrote:
> > Make calls to ct_user_enter when the kernel is exited
> > and ct_user_exit when the kernel is entered (in el0_da,
> > el0_ia, el0_svc, el0_irq).
> 
> Why only these entry points? I can reschedule after any exception from EL0,
> so I'd expect all exceptions from userspace to need annotating, no?
> 
> > These macros expand to function calls which will only work
> > properly if el0_sync and related code has been rearranged
> > (in a previous patch of this series).
> > 
> > In order to avoid saving registers, the slow syscall path
> > is forced (as x86 does).
> 
> ... and if you decide to handle undef exceptions, I think you'll need
> the register saving too, in case the kernel needs to perform emulation.

These are excellent points, I will rework the patch and submit v3.

Thanks for the feedback.

> 
> Will

Larry
