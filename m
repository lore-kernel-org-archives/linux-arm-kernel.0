From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 13 Sep 2016 13:38:44 -0600
Subject: [PATCH v5 02/16] dt/bindings: Update binding for PM domain idle
 states
In-Reply-To: <87intz665i.fsf@arm.com>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
 <1472242678-33700-3-git-send-email-lina.iyer@linaro.org>
 <0b233802-f459-c6bb-ff42-70745a225cfb@arm.com>
 <20160902201605.GA1705@linaro.org> <87sht59mcw.fsf@arm.com>
 <20160912161600.GA21885@linaro.org>
 <a4fc71ae-6fa5-4142-6dd4-7bc96eb20186@arm.com>
 <87intz665i.fsf@arm.com>
Message-ID: <20160913193844.GB28944@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13 2016 at 11:50 -0600, Brendan Jackman wrote:
>
>On Mon, Sep 12 2016 at 18:09, Sudeep Holla wrote:
>> On 12/09/16 17:16, Lina Iyer wrote:
>>> On Mon, Sep 12 2016 at 09:19 -0600, Brendan Jackman wrote:
>>>>
>>>> Hi Lina,
>>>>
>>>> Sorry for the delay here, Sudeep and I were both been on holiday last
>>>> week.
>>>>
>>>> On Fri, Sep 02 2016 at 21:16, Lina Iyer wrote:
>>>>> On Fri, Sep 02 2016 at 07:21 -0700, Sudeep Holla wrote:
>>>> [...]
>>>>>> This version is *not very descriptive*. Also the discussion we had
>>>>>> on v3
>>>>>> version has not yet concluded IMO. So can I take that we agreed on what
>>>>>> was proposed there or not ?
>>>>>>
>>>>> Sorry, this example is not very descriptive. Pls. check the 8916 dtsi
>>>>> for the new changes in the following patches. Let me know if that makes
>>>>> sense.
>>
>> Please add all possible use-cases in the bindings. Though one can refer
>> the usage examples, it might not cover all usage descriptions. It helps
>> preventing people from defining their own when they don't see examples.
>> Again DT bindings are like specifications, it should be descriptive
>> especially this kind of generic ones.
>>
>>>>
>>>> The not-yet-concluded discussion Sudeep is referring to is at [1].
>>>>
>>>> In that thread we initially proposed the idea of, instead of splitting
>>>> state phandles between cpu-idle-states and domain-idle-states, putting
>>>> CPUs in their own domains and using domain-idle-states for _all_
>>>> phandles, deprecating cpu-idle-states. I've brought this up in other
>>>> threads [2] but discussion keeps petering out, and neither this example
>>>> nor the 8916 dtsi in this patch series reflect the idea.
>>>>
>>> Brendan, while your idea is good and will work for CPUs, I do not expect
>>> other domains and possibly CPU domains on some architectures to follow
>>> this model. There is nothing that prevents you from doing this today,
>
>As I understand it your opposition to this approach is this:
>
>There may be devices/CPUs which have idle states which do not constitute
>"power off". If we put those  devices in their own power domain for the
>purpose of putting their (non-power-off) idle state phandles in
>domain-idle-states, we are "lying" because no true power domain exists
>there.
>
>Am I correct that that's your opposition?
>
>If so, it seems we essentially disagree on the definition of a power
>domain, i.e. you define it as a set of devices that are powered on/off
>together while I define it as a set of devices whose power states
>(including idle states, not just on/off) are tied together. I said
>something similar on another thread [1] which died out.
>
>Do you agree that this is basically where we disagree, or am I missing
>something else?
>
>[2] http://www.spinics.net/lists/devicetree/msg141050.html
>
Yes, you are right, I disagree with the definition of a domain around a
device. However, as long as you don't force SoC's to define devices in
the CPU PM domain to have their own virtual domains, I have no problem.
You are welcome to define it the way you want for Juno or any other
platform. I don't want that to be the forced and expected out of all
SoCs. All I am saying here is that the current implementation would
handle your case as well.

Thanks,
Lina

>>> you can specify domains around CPUs in your devicetree and CPU PM will
>>> handle the hierarchy. I don't think its fair to force it on all SoCs
>>> using CPU domains.
>>
>> I disagree. We are defining DT bindings here and it *should* be same for
>> all the SoC unless there is a compelling reason not to. I am fine if
>> those reasons are stated and agreed.
>>
>>> This patchset does not restrict you from organizing
>>> the idle states the way you want it. This revision of the series, clubs
>>> CPU and domain idle states under idle-states umbrella. So part of your
>>> requirement is also satisfied.
>>>
>>
>> I will look at the DTS changes in the series. But we *must* have more
>> description with more examples in the binding document.
>>
>>> You can follow up the series with your new additions, I don't see a
>>> conflict with this change.
>>>
>>
>> If we just need additions, then it should be fine.
