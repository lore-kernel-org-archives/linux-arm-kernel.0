From: drjones@redhat.com (Andrew Jones)
Date: Thu, 15 Mar 2018 15:39:53 +0100
Subject: [PATCH v6 19/26] arm64: KVM: Move stashing of x0/x1 into the
 vector code itself
In-Reply-To: <20180314165049.30105-20-marc.zyngier@arm.com>
References: <20180314165049.30105-1-marc.zyngier@arm.com>
 <20180314165049.30105-20-marc.zyngier@arm.com>
Message-ID: <20180315143953.gaz6z4uamzleyper@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 04:50:42PM +0000, Marc Zyngier wrote:
> All our useful entry points into the hypervisor are starting by
> saving x0 and x1 on the stack. Let's move those into the vectors
> by introducing macros that annotate whether a vector is valid or
> not, thus indicating whether we want to stash registers or not.
> 
> The only drawback is that we now also stash registers for el2_error,
> but this should never happen, and we pop them back right at the
> start of the handling sequence.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/hyp/hyp-entry.S | 56 ++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
