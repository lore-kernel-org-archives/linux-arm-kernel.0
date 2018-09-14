From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 14 Sep 2018 18:23:42 +0100
Subject: [PATCH] arm64: sysreg: Clean up instructions for modifying PSTATE
 fields
In-Reply-To: <20180914171238.ztf6qcy6ws7sjzkf@armageddon.cambridge.arm.com>
References: <20180914090749.18562-1-suzuki.poulose@arm.com>
 <20180914171238.ztf6qcy6ws7sjzkf@armageddon.cambridge.arm.com>
Message-ID: <ddf76575-fd1e-a45f-64e1-1ba54be47d51@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 14/09/18 18:12, Catalin Marinas wrote:
> Hi Suzuki,
> 
> On Fri, Sep 14, 2018 at 10:07:49AM +0100, Suzuki K. Poulose wrote:
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index c1470931b897..68c22360551e 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h

..

>> +#define SET_PSTATE_PAN(x)		__emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
>> +#define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
> 
> Could you please rebase this on top of arm64 for-next/core and also fix
> Will's SSBS macros which conflict with the above?
> 

Sure, will do.

Suzuki
