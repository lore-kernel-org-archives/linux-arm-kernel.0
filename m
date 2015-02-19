From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 19 Feb 2015 14:16:11 +0000
Subject: [PATCH v5 5/5] drivers: clocksource: add CPU PM notifier for ARM
 architected timer
In-Reply-To: <loom.20150219T133753-438@post.gmane.org>
References: <1377686689-30828-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1377686689-30828-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <521DD72D.7070000@arm.com>
 <loom.20150219T133753-438@post.gmane.org>
Message-ID: <CAPKp9uZj3tUVKf=mMRU+5hS0Ut31rrG5NHzo8=6Tw1ar+3+vZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Venkappa,

First of all, please make sure the relevant mailing list(ALKML in this case)
and maintainers (MarcZ and Catalin as you are addressing him) are cc-ed,
else there's every chance that the mail gets lost.

On Thu, Feb 19, 2015 at 1:03 PM, Venkappa Mala <venkappa.m@samsung.com> wrote:
> Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha <at> arm.com> writes:
>
>>
>> On 28/08/13 11:44, Sudeep KarkadaNagesha wrote:
>> > From: Sudeep KarkadaNagesha <sudeep.karkadanagesha <at> arm.com>
>> >
>> > Few control settings done in architected timer as part of
> initialisation
>> > can be lost when CPU enters deeper power states. They need to be
>> > re-initialised when the CPU is (warm)reset again.
>> >
>> > This patch adds CPU PM notifiers to do the timer initialisation on
> warm
>> > resets. It also save the event stream divider value calculated
> during
>> > cold reset and uses the same in warm reset path.
>> >
>> Ah, forgot to update the commit log. It's now updated:
>>
>> Few control settings done in architected timer as part of
> initialisation
>> can be lost when CPU enters deeper power states. They need to be
>> restored when the CPU is (warm)reset again.
>>
>> This patch adds CPU PM notifiers to save the counter control register
>> when entering low power modes and restore it when CPU exits low power.
>>
>> > Cc: Catalin Marinas <catalin.marinas <at> arm.com>
>> > Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi <at> arm.com>
>> > Reviewed-by: Will Deacon <will.deacon <at> arm.com>
>> > Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha <at>
> arm.com>

[...]

> Hello Catalin,
>
> I have noticed this patch merge in
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> at >= linux-3.13.y branches.
>
> As part of ARMv7/ARMv8 vDSO experiments, i have tried to enable arch
> timer in 3.10 branch but it is failed to boot like
> "[1246696886.455361]      swapper/0:    0] [c0] [c0] Calibrating delay
> loop (skipped), value calculated using timer frequency.. 52.00 BogoMIPS
> (lpj=260000)"
> due to cntkctl context lost on both armv7/armv8 cases.However, it works
> fine when I have pulled the patch to 3.10 branch.
>
> Perhaps, it will be good to have this patch in 3.10.y (LTS kernel)
> branch as well.
> is there any potential issue if we merge this patch or is it
> intentional?
>

Are you targeting this on ARM64 platform ?
If so, I don't understand how is the arch timer context is lost as the cpuidle
driver is not merge to 3.10 stable kernel ?

Regards,
Sudeep
