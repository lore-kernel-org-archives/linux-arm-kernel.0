From: afzal@ti.com (Afzal Mohammed)
Date: Thu, 29 Aug 2013 19:30:57 +0530
Subject: [PATCH v2 00/13] ARM: OMAP2+: AM43x PRCM support
In-Reply-To: <5214A83A.5080701@ti.com>
References: <cover.1375443858.git.afzal@ti.com> <5214A83A.5080701@ti.com>
Message-ID: <521F5419.2060801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul, Benoit,

On Wednesday 21 August 2013 05:14 PM, Rajendra Nayak wrote:
> On Friday 02 August 2013 07:05 PM, Afzal Mohammed wrote:

>> Hwmod database of AM335x is reused by moving common elements to a new
>> array (most of AM335x IP's are present in AM43x) and keeping separate
>> arrays for elements that are specific only to either one of AM335x or
>> AM43x. And in the cases where relevant IP is present in both that has
>> difference in details like CLKCTRL register offsets, it is being
>> updated at runtime based on the SoC detected.
> 
> I feel the reuse part is good but we need to structure them such that we
> don't compromise too much on readability of the data.
> 
> So what I suggest is
> 1. Create something like omap_hwmod_am43_am33_interconnect_data.c and have all common
> interconnect ocp_if structs
> 2. Create something like omap_hwmod_am43_am33_ipblock_data.c and have all common
> hwmod structs.
> 3. Since most PRCM register offsets are different, have them all inited in *one* place
> (even for the ones which are common), instead of common ones being statically defined
> and others dynamically inited.
> 4. For instances like clkdm being different or clock topology has changed (which is in
> rare cases) have seperate structures for am33xx and am43xx. Once we move some of the clocks etc
> to DT we can then move them into common files if needed.
> 
> Paul/Benoit, does the above make sense?

I plan to proceed as per the above 4 points mentioned by Rajendra (that
includes his comments on patches 2,3 & 13), is that okay ?

Regards
Afzal
