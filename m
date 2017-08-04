From: panand@redhat.com (Pratyush Anand)
Date: Fri, 4 Aug 2017 18:19:20 +0530
Subject: [PATCH 0/3] interrupted single step fixes
In-Reply-To: <20170803151533.29438-1-james.morse@arm.com>
References: <20170803151533.29438-1-james.morse@arm.com>
Message-ID: <515dfb90-5313-fe6c-673b-a25da43e186e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Thanks a lot for looking into it.

On Thursday 03 August 2017 08:45 PM, James Morse wrote:
> Enable CONFIG_SAMPLE_HW_BREAKPOINT, then:
>> insmod data_breakpoint.ko ksym=__sysrq_enabled
>> cat /proc/sys/kernel/sysrq
> With mainline you will hit the watchpoint forever, Pratyush's patches
> reduce this to ~10 times. These patches reduce that to the expected
> once.

So, when you say that it reduce to ~10 times with my patches, did you use all 
patches ie 1-4 or only 1-3. 1-3 is just the preparation and 4 was my actual 
solution. I had seen only once (which is expected) with all(1-4) of my 
patches. Please let me know if I missed any observation.

In my understanding, you have used 1-3 of mine and then replaced my 4th patch 
with your patches in this series.If I understood correctly then, now we can 
handle IRQ between breakpoint and step handler, I think thats good. Only 
concern seems that how does this approach behave when we put a hardware 
breakpoint on a ISR called between breakpoint and step exception.


-- 
Regards
Pratyush
