From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 14 May 2015 14:44:44 +0100
Subject: [PATCH 2/5] arm64: Juno: Split juno.dts into juno-base.dtsi and
 juno.dts.
In-Reply-To: <1431601471.2881.36.camel@linaro.org>
References: <1431537092-19597-1-git-send-email-Liviu.Dudau@arm.com>	
 <1431537092-19597-3-git-send-email-Liviu.Dudau@arm.com>	
 <1431596142.2881.13.camel@linaro.org>	
 <20150514103040.GN2345@e106497-lin.cambridge.arm.com>
 <1431601471.2881.36.camel@linaro.org>
Message-ID: <5554A6CC.7050903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/05/15 12:04, Jon Medhurst (Tixy) wrote:
> On Thu, 2015-05-14 at 11:30 +0100, Liviu Dudau wrote:
>> On Thu, May 14, 2015 at 10:35:42AM +0100, Jon Medhurst (Tixy) wrote:
> [...]
>>>
>>> What criteria were used to select the contents of juno-base.dtsi?
>>>  From what I can see, the stuff left out of base is still the same for r0
>>> and r1 (cpu, pmu, memory, psci!).
> [...]
>>
>> There are potential differences. Cortex-A53 cluster in r1 has limited
>> CPUfreq functionality due to a chip errata and there were talks internally
>> to actually disable it, hence the reason for keeping CPUs outside the
>> juno-base.dtsi. r2 will have a different set of big CPUs as well, so this
>> is preparing for the future as well.
>>
>> PMU are linked to the CPUs, hence the reason they stayed. As for the
>> memory and psci nodes the thinking behind it was mostly to allow for
>> ACPI to make changes there, but it does look now like retrofitting an
>> explanation to something that I did not give too much thought at that
>> moment.
>
> I guess my concern was motivated by the selfish aspect of having to
> maintain a bunch of out-of-tree Juno patches (like cpuidle and cpufreq

Hopefully not too long :)

> related DT updates) and having to duplicate those in more than one DT,
> and also having backport DT reorgs like this patch. Of course, none of
> that should be a consideration in deciding what goes into mainline, I
> just wanted to make sure there was a reason for the patch.
>

But I agree with you to remove duplicates as much as possible. Since
it's not possible to speculate how things will be in future platform,
IMO we can have all the device nodes that are common to both r0 and r1
in juno-base.dtsi for now and move them out as and when required.

Regards,
Sudeep
