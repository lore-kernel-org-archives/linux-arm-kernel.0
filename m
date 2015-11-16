From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Nov 2015 14:43:26 +0000
Subject: [PATCH 17/21] arm64: KVM: Map the kernel RO section into HYP
In-Reply-To: <20151116142728.GJ20696@leverpostej>
References: <1447679519-17888-1-git-send-email-marc.zyngier@arm.com>
 <1447679519-17888-18-git-send-email-marc.zyngier@arm.com>
 <20151116142728.GJ20696@leverpostej>
Message-ID: <5649EB8E.2030305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/11/15 14:27, Mark Rutland wrote:
> On Mon, Nov 16, 2015 at 01:11:55PM +0000, Marc Zyngier wrote:
>> In order to run C code in HYP, we must make sure that the kernel's
>> RO section in mapped into HYP (otherwise things break badly).
> 
> Somewhat tangential, but do we have any strong guarantees that the hyp
> text is otherwise safe in its address space which differs from that of
> the kernel proper?
> 
> i.e. do we need something like we did for the EFI stub in commit
> e8f3010f7326c003 ("arm64/efi: isolate EFI stub from the kernel proper")?

Probably. That will make things more difficult for VHE, where there are
function calls between the kernel and the "hypervisor" (kvm_call_hyp()
and panic() are the most obvious ones).

I'll have a look, thanks for the pointer.

	M.
-- 
Jazz is not dead. It just smells funny...
