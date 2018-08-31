From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Fri, 31 Aug 2018 00:30:50 +0000
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com> <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
 <20180830204515.GC24124@hirez.programming.kicks-ass.net>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090FF3@us01wembx1.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2018 01:45 PM, Peter Zijlstra wrote:
>>
>> Indeed this is the mother of all issues, I tried and system is clearly hosed with
>> and works after.
>> What's amazing is the commit 4aef66c8ae9 which introduced it is from 2016 ;-)
>> Back then we had a retry branch with backoff stuff which I'd reverted for new
>> cores and the merge conflict somehow missed it.
>>
>> @PeterZ I'll create a patch with you as author ? do I need any formal sign offs,
>> acks etc ?
> Well, Will spotted it, give authorship to him, you have my ack per the
> above.

Oops, sorry for the mixup. I have him as author now and pushed to ARC for-curr
(will trickle into linux-next eventually).

> FWIW, also ACK on Will's patch to switch you over to asm-generic bitops
> entirely.

Yeah I'll get it to that and your's after the clear_bit_lock stuff - sorry for
hijacking this thread to that topic now

-Vineet
