From: JBeulich@suse.com (Jan Beulich)
Date: Thu, 05 Nov 2015 10:21:08 -0700
Subject: [Xen-devel] [PATCH 2/3] xen/arm: introduce
 HYPERVISOR_dom0_op on arm and arm64
In-Reply-To: <1446743385-12848-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <1446743385-12848-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <563B9E1402000078000B247C@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 05.11.15 at 18:09, <stefano.stabellini@eu.citrix.com> wrote:
> --- a/arch/arm/xen/hypercall.S
> +++ b/arch/arm/xen/hypercall.S
> @@ -89,6 +89,7 @@ HYPERCALL2(memory_op);
>  HYPERCALL2(physdev_op);
>  HYPERCALL3(vcpu_op);
>  HYPERCALL1(tmem_op);
> +HYPERCALL1(dom0_op);

Assuming this somehow tries to mirror x86 naming - time to rename it
there? I don't see why you'd want to introduce a dom0_op when it
has been renamed to platform_op many years ago - see
public/dom0_ops.h.

Jan
