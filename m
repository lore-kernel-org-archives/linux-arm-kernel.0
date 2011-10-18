From: gdavis@mvista.com (George G. Davis)
Date: Tue, 18 Oct 2011 14:13:54 -0400
Subject: [RFC/PATCH v4 4/7] ARM: ARM11 MPCore: clean_dcache_area is not
	preempt safe
In-Reply-To: <20111018174319.GE27515@atomide.com>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-5-git-send-email-gdavis@mvista.com>
	<20111018170839.GD27515@atomide.com>
	<F772D91A-6D3A-40F4-ABF5-59C42FD2606E@mvista.com>
	<20111018174319.GE27515@atomide.com>
Message-ID: <C0570533-A72E-4628-AA23-3D65358ED317@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 18, 2011, at 1:43 PM, Tony Lindgren wrote:

> * George G. Davis <gdavis@mvista.com> [111018 09:56]:
>> Hello Tony/Ohad,
>> 
>> On Oct 18, 2011, at 1:08 PM, Tony Lindgren wrote:
>> 
>>> Hi,
>>> 
>>> * gdavis at mvista.com <gdavis@mvista.com> [111018 06:13]:
>>>> From: George G. Davis <gdavis@mvista.com>
>>>> 
>>>> If preemption and subsequent task migration occurs during calls to
>>>> clean_dcache_area on ARM11 MPCore machines, global memory state
>>>> can become inconsistent.  To prevent inconsistent memory state on
>>>> these machines, disable preemption in callers of these functions
>>>> around memory modifications and subsequent clean_dcache_area calls.
>>> 
>>> This one needs to be refreshed against what's queued in for-next as
>>> Ohad has moved most of the iommu code into drivers. I've added
>>> Ohad to Cc as well.
>> 
>> If you do not use ARM11 MPCore with those drivers, then we can drop this altogether.
> 
> No MPCore omaps available AFAIK, so that sounds OK to me.

Good, I'll drop it then.

Thanks!

--
Regards,
George

> 
> Tony
