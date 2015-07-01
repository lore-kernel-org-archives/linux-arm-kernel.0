From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 01 Jul 2015 11:56:34 +0100
Subject: [PATCH 2/2] arm/arm64: KVM: fix two build failured under
 STRICT_MM_TYPECHECKS
In-Reply-To: <20150630170315.GL7445@e104818-lin.cambridge.arm.com>
References: <1435680290-13945-1-git-send-email-ard.biesheuvel@linaro.org>
 <1435680290-13945-2-git-send-email-ard.biesheuvel@linaro.org>
 <20150630170315.GL7445@e104818-lin.cambridge.arm.com>
Message-ID: <5593C762.1050309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/15 18:03, Catalin Marinas wrote:
> On Tue, Jun 30, 2015 at 06:04:50PM +0200, Ard Biesheuvel wrote:
>> This fixes two instances where a pgprot_t is used as the operand
>> of a bitwise & operation. In order to comply with STRICT_MM_TYPECHECKS,
>> bitwise arithmetic on a pgprot_t should go via the pgprot_val()
>> accessor.
>>
>> Cc: kvmarm at lists.cs.columbia.edu
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> (I guess it will go via the kvm tree)

Yes, I'll queue it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
