From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Nov 2015 17:41:53 +0000
Subject: [PATCH 04/21] arm64: KVM: Implement vgic-v3 save/restore
In-Reply-To: <20151120164851.GB24960@linaro.org>
References: <1447679519-17888-1-git-send-email-marc.zyngier@arm.com>
 <1447679519-17888-5-git-send-email-marc.zyngier@arm.com>
 <20151120164851.GB24960@linaro.org>
Message-ID: <564F5B61.8000701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/15 16:48, Steve Capper wrote:
> On Mon, Nov 16, 2015 at 01:11:42PM +0000, Marc Zyngier wrote:
>> Implement the vgic-v3 save restore as a direct translation of
>> the assembly code version.
> 
> I think there's a couple of typos below Marc.

[...]

>> +	case 10:
>> +		cpu_if->vgic_lr[LR_OFFSET(19)] = read_gicreg(ICH_LR10_EL2);
> 
> LR_OFFSET(10) ?

Memory corruption, here we come!!!! ;-)

Thanks, I'll fix those!

	M.
-- 
Jazz is not dead. It just smells funny...
