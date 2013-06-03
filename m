From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 3 Jun 2013 17:25:18 +0100
Subject: [PATCH v2 5/5] arm64/xen: introduce CONFIG_XEN and hypercall.S
 on ARM64
In-Reply-To: <1370273624-26976-5-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1306031157020.4589@kaball.uk.xensource.com>
 <1370273624-26976-5-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130603162517.GC32295@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 04:33:44PM +0100, Stefano Stabellini wrote:
> --- /dev/null
> +++ b/arch/arm64/xen/hypercall.S
...
> +/*
> + * The Xen hypercall calling convention is very similar to the ARM AEBI
> + * procedure calling convention: the first paramter is passed in x0, the
> + * second in x1, the third in x2 and the fourth in x3. Considering that
> + * Xen hypercalls have 5 arguments at most, the fifth paramter is passed
> + * in rx, differently from the procedure calling convention of using the
> + * stack for that case.

You may want to use the AArch64 ABI here where parameters are passed in
x0-x7, return in x0.

BTW, I think it's missing a MAINTAINERS file update.

Otherwise, the series looks good. How do you plan to upstream this?

-- 
Catalin
