From: cornelia.huck@de.ibm.com (Cornelia Huck)
Date: Thu, 30 Oct 2014 13:06:58 +0100
Subject: [PATCH v12 1/6] KVM: Add architecture-defined TLB flush support
In-Reply-To: <1414017251-5772-2-git-send-email-m.smarduch@samsung.com>
References: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
 <1414017251-5772-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <20141030130658.2b8f183e.cornelia.huck@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Oct 2014 15:34:06 -0700
Mario Smarduch <m.smarduch@samsung.com> wrote:

> This patch adds support for architecture implemented VM TLB flush, currently
> ARMv7 defines HAVE_KVM_ARCH_TLB_FLUSH_ALL. This leaves other architectures 
> unaffected using the generic version. In subsequent patch ARMv7 defines
> HAVE_KVM_ARCH_TLB_FLUSH_ALL and it's own TLB flush interface.

Can you reword this a bit?

"Allow architectures to override the generic kvm_flush_remote_tlbs()
function via HAVE_KVM_ARCH_TLB_FLUSH_ALL. ARMv7 will need this to
provide its own TLB flush interface."

> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  virt/kvm/Kconfig    |    3 +++
>  virt/kvm/kvm_main.c |    2 ++
>  2 files changed, 5 insertions(+)

Providing an override for the special cases looks sane to me.
