From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Apr 2013 14:52:35 +0100
Subject: [PATCH v3 31/32] arm64: KVM: userspace API documentation
In-Reply-To: <20130423230252.GO20569@gmail.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-32-git-send-email-marc.zyngier@arm.com>
 <20130423230252.GO20569@gmail.com>
Message-ID: <5177E3A3.4000600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/13 00:02, Christoffer Dall wrote:
> On Mon, Apr 08, 2013 at 05:17:33PM +0100, Marc Zyngier wrote:
>> Unsurprisingly, the arm64 userspace API is extremely similar to
>> the 32bit one, the only significant difference being the ONE_REG
>> register mapping.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

[...]

>> +
>> +arm64 registers are mapped using the lower 32 bits. The upper 16 of
>> +that is the register group type, or coprocessor number:
>> +
>> +arm64 core/FP-SIMD registers have the following id bit patterns:
>> +  0x6002 0000 0010 <index into the kvm_regs struct:16>
>> +
>> +arm64 CCSIDR registers are demultiplexed by CSSELR value:
>> +  0x6002 0000 0011 00 <csselr:8>
>> +
>> +arm64 system registers have the following id bit patterns:
>> +  0x6002 0000 0013 <op0:2> <op1:3> <crn:4> <crm:4> <op2:3>
>> +
> 
> I think these size encodings are 4 bits off, and not accurate for for
> the core registers, which have variable sizes, which should be indicated
> here (unless you decide for a separate category as per my other
> comment).

Indeed you're right, they're completely wrong. I realized that after
your 32bit patch fixing the same thing...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
