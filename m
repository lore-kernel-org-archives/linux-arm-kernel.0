From: james.morse@arm.com (James Morse)
Date: Mon, 13 Mar 2017 17:59:11 +0000
Subject: [PATCH v3 04/25] arm64: KVM: Allow the main HYP code to use the
 init hyp stub implementation
In-Reply-To: <20170306142458.8875-5-marc.zyngier@arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
 <20170306142458.8875-5-marc.zyngier@arm.com>
Message-ID: <58C6DDEF.3080100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/17 14:24, Marc Zyngier wrote:
> We now have a full hyp-stub implementation in the KVM init code,
> but the main KVM code only supports HVC_GET_VECTORS, which is not
> enough.
> 
> Instead of reinventing the wheel, let's reuse the init implementation
> by branching to the idmap page when called with a hyp-stub hypercall.

Since your merged page tables change this isn't as scary as it looks, as the
idmap is always present.


Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
