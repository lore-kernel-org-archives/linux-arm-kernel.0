From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 14 Sep 2016 13:37:10 +0200
Subject: [PATCH v5 02/16] dt/bindings: Update binding for PM domain idle
 states
In-Reply-To: <87h99i6b5d.fsf@arm.com>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
 <1472242678-33700-3-git-send-email-lina.iyer@linaro.org>
 <0b233802-f459-c6bb-ff42-70745a225cfb@arm.com>
 <20160902201605.GA1705@linaro.org> <87sht59mcw.fsf@arm.com>
 <20160912161600.GA21885@linaro.org>
 <a4fc71ae-6fa5-4142-6dd4-7bc96eb20186@arm.com>
 <87intz665i.fsf@arm.com> <20160913193844.GB28944@linaro.org>
 <87h99i6b5d.fsf@arm.com>
Message-ID: <CAPDyKFrrOjNv1a7VzT9_KWEBDmbE7dnC3RUtg6r+QEbCsbXh9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>
>> Yes, you are right, I disagree with the definition of a domain around a
>> device.

To fill in, I agree with Lina (and Kevin).

>From my point of view, a domain is per definition containing resources
which are shared among devices. Having one device per domain, does in
general not make sense.

> OK, great.
>> However, as long as you don't force SoC's to define devices in
>> the CPU PM domain to have their own virtual domains, I have no problem.
>> You are welcome to define it the way you want for Juno or any other
>> platform.
> I don't think that's true; the bindings have to work the same way for
> all platforms. If for Juno we put CPU idle state phandles in a
> domain-idle-states property for per-CPU domains then, with the current
> implementation, the CPU-level idle states would be duplicated between
> cpuidle and the CPU PM domains.
>> I don't want that to be the forced and expected out of all
>> SoCs. All I am saying here is that the current implementation would
>> handle your case as well.
>
> The current implementation certainly does cover the work I want to
> do. The suggestion of per-device power domains for devices/CPUs with
> their own idle states is simply intended to minimise the binding design,
> since we'd no longer need cpu-idle-states or device-idle-states
> (the latter was proposed elsewhere).

I see your point, but IMHO that would be to simplify the description
of the hardware. And I don't think it's sufficient to cover all
existing cases.

>
> I am fine with the bindings as they are implemented currently so long
> as:
>
> - The binding doc makes clear how idle state phandles should be split
>   between cpu-idle-states and domain-idle-states. It should make it
>   obvious that no phandle should ever appear in both properties. It
>   would even be worth briefly going over the backward-compatibility
>   implications (e.g. what happens with old-kernel/new-DT and
>   new-kernel/old-DT combos if a platform has OSI and PC support and we
>   move cluster-level idle state phandles out of cpu-idle-states and into
>   domai-idle-states).
>
> - We have a reason against the definition of power domains as "a set of
>   devices bound by a common power (including idle) state", since that
>   definition would simplify the bindings. In my view, "nobody thinks
>   that's what a power domain is" _is_ a compelling reason, so if others
>   on the list get involved I'm convinced. I think I speak for Sudeep
>   here too.
>

>From a CPU point of view, I think it may very well be considered as
any other device. Yes, we have treated them in a specific manner
regarding the idle state definitions we currently have - and we can
continue to do that.

Although, in the long run, I think we needs something more flexible
that can be used for domains and devices.

Kind regards
Uffe
