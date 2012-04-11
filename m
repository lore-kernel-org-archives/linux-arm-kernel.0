From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 11 Apr 2012 13:17:52 +0530
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <CACVXFVMtPEo1h6auh8gc=ZAxb0+w_-Jy7ARixS30k=9-TeKrkw@mail.gmail.com>
References: <79CD15C6BA57404B839C016229A409A83184846A@DBDE01.ent.ti.com>
 <20120405095221.GC25053@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A831848621@DBDE01.ent.ti.com>
 <87hawxkgoi.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com>
 <20120406180452.GB15734@atomide.com>
 <79CD15C6BA57404B839C016229A409A83184ABEF@DBDE01.ent.ti.com>
 <4F83440E.70502@ti.com> <20120410084413.GD25053@n2100.arm.linux.org.uk>
 <4F83F600.4000002@ti.com> <20120410092904.GE25053@n2100.arm.linux.org.uk>
 <CAMQu2gwSAPtXOYWP1VmVCuxru_CrbLC-gLaaD7n4+utu3rOwxQ@mail.gmail.com>
 <CACVXFVMtPEo1h6auh8gc=ZAxb0+w_-Jy7ARixS30k=9-TeKrkw@mail.gmail.com>
Message-ID: <CAMQu2gyNO5tKyR_ur_LR=FAsQvA=GC8gb=GV85ziAjvkGLgYnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 6:30 AM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Tue, Apr 10, 2012 at 5:51 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Tue, Apr 10, 2012 at 2:59 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Tue, Apr 10, 2012 at 02:27:36PM +0530, Santosh Shilimkar wrote:
>>>> On Tuesday 10 April 2012 02:14 PM, Russell King - ARM Linux wrote:
>>>> > On Mon, Apr 09, 2012 at 03:18:22PM -0500, Jon Hunter wrote:
>>>> >> True, but we would always want to use the 32k timer if CONFIG_PM is
>>>> >> specified. So what I am saying is that if a device has a 32ksync timer
>>>> >> and CONFIG_PM is defined, we always want to use the 32ksync timer and a
>>>> >> gptimer should never be used.
>>>> >
>>>> > Why? ?What if you want to have PM enabled, and you also want to use the
>>>> > kernels high resolution timers, or you want more accurate timing than
>>>> > the 30.5us tick interval of the 32k timer?
>>>>
>>>> You might have missed the earlier comments on the thread. High
>>>> resolution GP timer(sysclk) will stop in deeper power states and
>>>> hence it can't be used with PM enabled usecases.
>>>
>>> Which means folk should be given the choice at boot time between running
>>> with the deeper power states and having a higher resolution timing source,
>>> rather than denying them the higher resolution timing source when PM is
>>> enabled.
>>
>> Good point. My point is such facilities is already part of the kernel and
>> there is no need to add a new one. The last proposal was allowing user to
>> choose gptimer as a clocksource and then you already have facility to
>> disable C-state now so, all should work in general
>
> 'nohlt' in boot cmd should work to prevent CPU from entering deep C-state,
> which looks enough to make gptimer working well if system suspend isn't
> considered.
>
That's another good option

Looks like we get all the needed flexibility with the reworked patch
from Vaibhav
to choose the command like option for high res. timer source.

Regards
Santosh
