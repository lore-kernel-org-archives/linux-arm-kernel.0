From: ccross@google.com (Colin Cross)
Date: Fri, 21 Jan 2011 18:24:24 -0800
Subject: Locking in the clk API
In-Reply-To: <4D3A38A7.5000807@codeaurora.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org> <4D3862DB.5000708@fluff.org>
	<20110120185617.GI6335@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101201623480.8580@xanadu.home>
	<AANLkTimwBruVgGQWs5NQG7U3PcF6RQHZ6Pd1hjxyGpcA@mail.gmail.com>
	<4D3907BD.4040900@codeaurora.org>
	<20110121093218.GB13235@n2100.arm.linux.org.uk>
	<4D3A38A7.5000807@codeaurora.org>
Message-ID: <AANLkTimS_=JnKD42fMfD38vnaPQu2vfsSQvNs-mKsj=2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 5:53 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 01/21/2011 01:32 AM, Russell King - ARM Linux wrote:
>>
>> On Thu, Jan 20, 2011 at 08:12:45PM -0800, Saravana Kannan wrote:
>>>
>>> In my opinion, the only major reason for needing atomic clk APIs was due
>>> to device_ops->suspend being atomic. Since that's not the case anymore,
>>> I really don't see a justification for atomic clocks. Sure, I might have
>>> missed some exceptions, but in that case we should make the atomic APIs
>>> an exception (add clk_enable_atomic) and not the norm.
>>
>> The suspend method has never been atomic. ?It has always been able to
>> sleep. ?You're mistaken.
>
> I distinctly remember trying to do sleeping stuff inside a .suspend function
> and have it complain that it's atomic. So, I think you might be mistaken.
> But I will have to back up my claims. Let me trying to find that info. In
> the end, one of us will learn something new -- which is good and all that
> matters.

platform_driver->suspend and dev_pm_ops->suspend can sleep, but
dev_pm_ops->suspend_noirq is called after irqs are disabled and can't
sleep.  Maybe that's what you were using?
