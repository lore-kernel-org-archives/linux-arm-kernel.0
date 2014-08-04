From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Mon, 04 Aug 2014 13:35:15 +0100
Subject: [PATCH] arm64: KVM: export current vcpu->pause state via pseudo
 regs
In-Reply-To: <20140804121655.GE524@cbox>
References: <1404914112-7298-1-git-send-email-alex.bennee@linaro.org>
 <53DA7583.2030504@redhat.com>
 <CAFEAcA9cT617t8JqOXtuO-wQ5xg5T3Sw_DUHB1fpPD6g3SSNaQ@mail.gmail.com>
 <53DA7B28.701@redhat.com> <20140804121655.GE524@cbox>
Message-ID: <877g2ol9dh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Christoffer Dall writes:

> On Thu, Jul 31, 2014 at 07:21:44PM +0200, Paolo Bonzini wrote:
>> Il 31/07/2014 19:04, Peter Maydell ha scritto:
>> > On 31 July 2014 17:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> >> Il 09/07/2014 15:55, Alex Benn?e ha scritto:
<snip>
>> 
>> No, it's not.  It's just the state of the CPU, s390 will be using it too.
>> 
>> On x86 the states are uninitialized (UNINITIALIZED), stopped
>> (INIT_RECEIVED), running (RUNNABLE), halted (HALTED).  CPU 0 starts in
>> RUNNABLE state, other CPUs start in UNINITIALIZED state.  There are
>> x86-specific cases (uninitialized) and x86-isms (the INIT_RECEIVED
>> name), but the idea is widely applicable.
>> 
> Alex, I think it makes perfect sense to use GET/SET_MP_STATE, will you
> revise the patch?

I agree we should use the API that is explicitly for this so I'm looking
at re-doing the patch now.

>
> (Don't forget to update the documentation to reflect it is now supported
> on ARM, and which states are used to represent what there.)
>
> Thanks,
> -Christoffer

-- 
Alex Benn?e
