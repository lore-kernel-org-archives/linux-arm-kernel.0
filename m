From: ccross@android.com (Colin Cross)
Date: Sun, 27 Jun 2010 19:30:01 -0700
Subject: [PATCH V2] [ARM] Add ARCH_PROVIDES_UDELAY config option
In-Reply-To: <4C200E62.4090604@codeaurora.org>
References: <1272654736-28837-1-git-send-email-ccross@android.com>
	<u2pd73d4eaf1004301237k3ceb859dobe74fe53abec774d@mail.gmail.com>
	<87d3xgd20n.fsf@deeprootsystems.com>
	<20100501100148.GE12172@n2100.arm.linux.org.uk>
	<4BF702CC.5000401@codeaurora.org>
	<20100521220653.GL11042@n2100.arm.linux.org.uk>
	<4BFF112A.2060700@codeaurora.org> <4C200E62.4090604@codeaurora.org>
Message-ID: <AANLkTim_Ct2EKfvQ119KRvMkqUyNivgnchEBkK7W4P_-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am using this patch in our Tegra development tree.  So far, I
haven't come across any need for supporting udelay before iomap, but
if it is necessary, it could be handled in the per-architecture
implementation by using a busy loop with a worst-case count if a
sched_clock initialization flag is not set.

On Mon, Jun 21, 2010 at 6:14 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> Russel,
>
> Would appreciate your thoughts on this.
>
> Colin,
>
> Are you continuing to use the approach used in your patch in your
> development tree? I just want to make sure we have a solution that everyone
> can agree to.
>
> Thanks,
> Saravana
>
> Saravana Kannan wrote:
>>
>> Russell King - ARM Linux wrote:
>>>
>>> My point is not specific to sched_clock, but to counters which on ARM
>>> are 99.9% always memory mapped, and therefore inaccessible during the
>>> very early kernel boot. ?sched_clock was merely an illustration of the
>>> problem.
>>
>> Do you know any code which uses udelay that early? I can't imagine any
>> non-driver code using udelay. If it's just drivers using udelay, then they
>> need IO mapping to have been completed for the device register access to
>> work and hence udelay won't have any problems.
>>
>> -Saravana
>>
>
>
