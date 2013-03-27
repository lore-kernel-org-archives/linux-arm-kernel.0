From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Mar 2013 20:25:10 +0100
Subject: [PATCH] ARM: KVM: promote
 =?UTF-8?Q?vfp=5Fhost=20pointer=20to=20gener?=
 =?UTF-8?Q?ic=20host=20cpu=20context?=
In-Reply-To: <1364315842-20317-1-git-send-email-marc.zyngier@arm.com>
References: <1364315842-20317-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <0c80d1e5b0850e2d49a657e07c04037d@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Mar 2013 16:37:22 +0000, Marc Zyngier <marc.zyngier@arm.com>
wrote:
> We use the vfp_host pointer to store the host VFP context, should
> the guest start using VFP itself.
> 
> Actually, we can use this pointer in a more generic way to store
> CPU speficic data, and arm64 is using it to dump the whole host
> state before switching to the guest.
> 
> Simply rename the vfp_host field to host_cpu_context, and the
> corresponding type to kvm_cpu_context_t. No change in functionnality.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

[snip]

This patch is broken, as it misses one critical hunk in asm-offset.c.
I'll repost an updated version tomorrow.

        M.
-- 
Fast, cheap, reliable. Pick two.
