From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jul 2010 22:16:29 +0100
Subject: [PATCH] [ARM] Introduce patching of phys_to_virt and vice versa
In-Reply-To: <1278083164.15298.55.camel@ra7055-laptop>
References: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
	<1278083164.15298.55.camel@ra7055-laptop>
Message-ID: <20100720211629.GB10553@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 10:06:04AM -0500, Rob Herring wrote:
> Should something more generic like the x86 alternative code be done for
> ARM? It's very likely we will need patching in other places like for UP
> and SMP in one kernel. 

I think yes, we need to - I can't see how we can sensibly combine
kernels without this.

However, the effect of this is that XIP can't use this - as the
kernel text is read-only.
