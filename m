From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 25 Nov 2011 13:29:13 +0000
Subject: [PATCH 4/4] [RFC] Use generic ARM instruction set condition code
 checks for kprobes.
In-Reply-To: <1322163625.2233.53.camel@computer2>
References: <20111121183046.28964.23829.stgit@localhost6.localdomain6>	
 <20111121183104.28964.87120.stgit@localhost6.localdomain6>	
 <1321953203.2557.55.camel@computer2> <4ECE78B6.9040408@arm.com>
 <1322163625.2233.53.camel@computer2>
Message-ID: <4ECF9829.8010101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/11 19:40, Tixy wrote:
>> Now, disabling the SWP emulation, it still fails - but at least not as
>> an oops this time:
>> <<<
>> FAIL: test memory differs
>> FAIL: Test strd r2, [r3], r4
>> FAIL: Scenario 0
...
>> FATAL: Error inserting test_kprobes
>>
> The kprobes instruction emulation has stored the original value of r3
> into memory, whereas the real instruction has store the updated value of
> r3. Either this instruction form is UNPREDICTABLE, in which case the
> test code should not be trying to test it, otherwise the instruction
> emulation code needs fixing. Either way, a patch is needed. I'll look
> into this.

Yes, this instruction form is UNPREDICTABLE, and some quick experiments 
show that it behaves differently on for example Cortex-A8 and Cortex-A9.

/
     Leif
