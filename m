From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 5 Jun 2013 13:23:34 +0100
Subject: [PATCH v3 5/6] arm64/xen: introduce CONFIG_XEN and hypercall.S
 on ARM64
In-Reply-To: <1370434530-22428-5-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1306041712100.4589@kaball.uk.xensource.com>
 <1370434530-22428-5-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1370435014.24512.190.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-06-05 at 13:15 +0100, Stefano Stabellini wrote:
> Introduce CONFIG_XEN and the implementation of hypercall.S (that is
> the only ARMv8 specific code in Xen support for ARM).
> 
> Compile enlighten.c and grant_table.c from arch/arm.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>

> [....]
> +#define HYPERCALL_SIMPLE(hypercall)		\
> +ENTRY(HYPERVISOR_##hypercall)			\
> +	mov x16, #__HYPERVISOR_##hypercall;	\
> +	hvc XEN_IMM;						\
> +	ret;								\

Not sure if this is corruption due to whitespace/email etc but it'd be
nice to align those \'s.

Ian.
