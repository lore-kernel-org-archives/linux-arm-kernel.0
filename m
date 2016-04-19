From: james.morse@arm.com (James Morse)
Date: Tue, 19 Apr 2016 09:58:46 +0100
Subject: [PATCH v7 01/16] arm64: KVM: Register CPU notifiers when the
 kernel runs at HYP
In-Reply-To: <20160418161037.GE18257@e104818-lin.cambridge.arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-2-git-send-email-james.morse@arm.com>
 <20160418161037.GE18257@e104818-lin.cambridge.arm.com>
Message-ID: <5715F346.2060804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 18/04/16 17:10, Catalin Marinas wrote:
> On Fri, Apr 01, 2016 at 05:53:25PM +0100, James Morse wrote:
>> When the kernel is running at EL2, it doesn't need init_hyp_mode() to
>> configure page tables for HYP. This function also registers the CPU
>> hotplug and lower power notifiers that cause HYP to be re-initialised
>> after the CPU has been reset.
>>
>> To avoid losing the register state that controls stage2 translation, move
>> the registering of these notifiers into init_subsystems(), and add a
>> is_kernel_in_hyp_mode() path to each callback.
>>
>> Fixes: 1e947bad0b6 ("arm64: KVM: Skip HYP setup when already running in HYP")
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> To the best of my knowledge of the hyp code:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks,

> Since it has a Fixes tag, does this need to be picked for 4.6 or a Cc:
> stable if it goes in later?

This patch was sent as a separate fix for rc1, its here too so that this series
can be applied directly from the list without conflicts after rc2.



James
