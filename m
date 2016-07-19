From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Jul 2016 13:44:15 +0100
Subject: [PATCH] arm64: KVM: VHE: Context switch MDSCR_EL1
In-Reply-To: <d1313d99-31dd-e799-7f5b-fb03f928cefd@redhat.com>
References: <1468918664-19130-1-git-send-email-marc.zyngier@arm.com>
 <d1313d99-31dd-e799-7f5b-fb03f928cefd@redhat.com>
Message-ID: <578E209F.10107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/16 13:25, Paolo Bonzini wrote:
> 
> 
> On 19/07/2016 10:57, Marc Zyngier wrote:
>> The kprobe enablement work has uncovered that changes made by
>> a guest to MDSCR_EL1 were propagated to the host when VHE was
>> enabled, leading to unexpected exception being delivered.
>>
>> Moving this register to the list of registers that are always
>> context-switched fixes the issue.
>>
>> Reported-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>
>> Tested-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/hyp/sysreg-sr.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)

[...]

> Can you add Fixes and Cc: stable headers?  Thanks,

Ah, I missed that. Thanks for the heads up, v2 coming shortly.

	M.
-- 
Jazz is not dead. It just smells funny...
