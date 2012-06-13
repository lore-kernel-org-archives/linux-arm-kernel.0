From: gdavis@mvista.com (George G. Davis)
Date: Wed, 13 Jun 2012 07:36:42 -0400
Subject: [RFC/PATCH v5 5/7] ARM: ARM11 MPCore: cpu_v6_dcache_clean_area
 needs RFO
In-Reply-To: <20120613093634.GA31722@n2100.arm.linux.org.uk>
References: <1318945654-548-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-6-git-send-email-gdavis@mvista.com>
 <20120613093218.GC29492@arm.com>
 <20120613093634.GA31722@n2100.arm.linux.org.uk>
Message-ID: <8AB666FE-C2D3-48B3-BF3E-2DC53BF5E0BD@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jun 13, 2012, at 5:36 AM, Russell King - ARM Linux wrote:

> On Wed, Jun 13, 2012 at 10:32:18AM +0100, Catalin Marinas wrote:
>> Alternatively, we could disable the interrupts around RFO and D-cache
>> cleaning (inside the loop), though I think the preempt disabling is
>> faster.
> 
> It also has the *important* effect that it doesn't cause problems with
> interrupt latency, which is a real concern if you have peripherals
> requiring quick servicing.

Yep, even disabling preemption is not acceptable for some work loads but this
is the least painful option here.

Thanks!

--
Regards,
George
