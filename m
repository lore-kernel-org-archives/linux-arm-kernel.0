From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 6 Jun 2013 10:03:39 +0100
Subject: [Xen-devel] [PATCH v4 5/6] arm64/xen: introduce CONFIG_XEN on
 ARM64
In-Reply-To: <1370451727-26826-5-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1306051605030.4589@kaball.uk.xensource.com>
 <1370451727-26826-5-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1370509419.24512.224.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-06-05 at 18:02 +0100, Stefano Stabellini wrote:
> Changes in v4:
> - build the entire arch/arm/xen directory under arch/arm64, ifdef
> hypercall.S appropriately.

This is probably the best (or equal first) of a bunch of bad options :-/

> + * The Xen hypercall calling convention is very similar to the ARM/ARM64
> + * procedure calling convention: the first paramter is passed in r0/x0,

"parameter"

> + * the second in r1/x1, the third in r2/x2 and the fourth in r3/x3.
> + * Considering that Xen hypercalls have 5 arguments at most, the fifth
> + * paramter is always passed in r4/x4, differently from the ARM
> + * procedure calling convention of using the stack for that case.

and "parameter" again.

Strictly speaking the fifth argument handling only differs from the
32-bit PCS, not the 64-bit one. Splitting hairs a bit there.

If you fix the typo and clarify the fifth argument or not as you wish:

        Acked-by: Ian Campbell <ian.campbell@citrix.com>

Ian.
