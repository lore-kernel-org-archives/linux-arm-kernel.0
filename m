From: maddy@linux.vnet.ibm.com (Madhavan Srinivasan)
Date: Sat, 7 Nov 2015 09:59:57 +0530
Subject: [RFC PATCH 0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
In-Reply-To: <20151106102540.GR3604@twins.programming.kicks-ass.net>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20151105130716.GC3604@twins.programming.kicks-ass.net>
 <563C5655.3000605@linux.vnet.ibm.com>
 <20151106092430.GO3604@twins.programming.kicks-ass.net>
 <1446804240.21859.4.camel@ellerman.id.au>
 <20151106102540.GR3604@twins.programming.kicks-ass.net>
Message-ID: <563D7E45.20304@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 06 November 2015 03:55 PM, Peter Zijlstra wrote:
> On Fri, Nov 06, 2015 at 09:04:00PM +1100, Michael Ellerman wrote:
>> It's a perrenial request from our hardware PMU folks to be able to see the raw
>> values of the PMU registers.
>>
>> I think partly it's so that they can verify that perf is doing what they want,
>> and some of it is that they're interested in some of the more obscure info that
>> isn't plumbed out through other perf interfaces.
>>
>> We've used various internal hacks over the years to keep them happy. This is an
>> attempt to use a somewhat standard mechanism.
>>
>> It would also be helpful for those of us working on the perf hardware backends,
>> to be able to verify that we're programming things correctly, without resorting
>> to debug printks etc.
>>
>> Basically we want to sample regs at the time of the perf interrupt, so we
>> though PERF_SAMPLE_REGS_INTR made senes :)
>>
>> But if you think this is the wrong mechanism within perf, then please let us
>> know.
>>
>> I know perf's mission is to abstract as much of the arcane hardware details
>> into a generic interface and make PMUs actually useful for normal folks, and we
>> are committed to that, but it would also be useful to be able to get the raw
>> values for a different type of user.
>>
>> Maddy's patch only exports PMC1-6 and MMCR0/1. I think we also need to export
>> some others, in particular MMCRA has a lot of stuff in it, half of which is not
>> even architected. So that would have to be exported as "POWER8_MMCRA". And then
>> there's the SIAR/SDAR/SIER which contain a bunch of info on sampled
>> instructions that is not currently plumbed out.
> OK, no objections then. But this is useful information and should be
> included in the patch set.
>

Sure. Will add the information in the next version.

Maddy
