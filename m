From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 18 Sep 2015 12:23:23 +0100
Subject: [RFC PATCH v2 0/7] Pseudo-NMI for arm64 using ICC_PMR_EL1 (GICv3)
In-Reply-To: <32CDD1A8-EF10-4F6B-86B6-64981874361A@jonmasters.org>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
 <32CDD1A8-EF10-4F6B-86B6-64981874361A@jonmasters.org>
Message-ID: <55FBF42B.2090806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/09/15 06:11, Jon Masters wrote:
>> On Sep 14, 2015, at 06:26, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>> This patchset provides a pseudo-NMI for arm64 kernels by reimplementing
>> the irqflags macros to modify the GIC PMR (the priority mask register is
>> accessible as a system register on GICv3 and later) rather than the
>> PSR. The patchset includes an implementation of
>> arch_trigger_all_cpu_backtrace() for arm64 allowing the new code to be
>> exercised.
>
> I think there is a need to connect a few dots on this next week
> during Connect. Some other conversations have discussed alternative
> implementations elsewhere. I will assist.

Fine by me.

I'd be very happy to talk about alternative approaches. In the past I've 
had long conversations about trapping to ARM TF as a means to simulate 
NMI. I haven't written any code to move in this direction but I still 
think of it as being the future-areas-of-interest pile.

That said, whenever I search for (what I think are) sensible keywords 
for this subject I generally only find my own work! I may be selecting a 
rather blinkered set of keywords when I search but nevertheless it does 
mean I will probably have to rely on you to make introductions!


Daniel.
