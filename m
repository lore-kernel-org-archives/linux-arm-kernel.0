From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun, 6 Dec 2015 22:33:50 +0900
Subject: [PATCH v8 0/4] arm64: Add support for IRQ stack
In-Reply-To: <20151204135752.GK10123@e104818-lin.cambridge.arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <20151204135752.GK10123@e104818-lin.cambridge.arm.com>
Message-ID: <7BAF1B7D-6A98-44D4-8F5B-AA6825B5DF8D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 4, 2015, at 10:57 PM, Catalin Marinas wrote:
> On Fri, Dec 04, 2015 at 11:02:24AM +0000, James Morse wrote:
>> Patch 4 is new, following Catalin's comments, but I don't think it is
>> necessary unless we also decrease the stack size,
> 
> That's the whole aim of this patchset, to try to to get back to 8KB
> stacks.
> 
>> which I don't think we should do immediatly - it would be good to
>> collect some max_stack_size values for various workloads first.
> 
> We could make it configurable though, maybe defaulting to 16KB for a
> while.
> 
> IIRC, the stack overflows we had in the past were triggered when running
> specweb but I don't remember whether it was hard or soft IRQs that
> caused the issues (could have been both). We could run some tests again
> and see how close we get to the 8KB limit.
> 
> BTW, what's the disadvantage of always switching to the IRQ stack in
> do_softirq?

As we know well, additional operations, such as IRQ count management and
stack pointer update, are the only items I'm aware of.

Best Regards
Jungseok Lee
