From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 11 Jul 2014 11:51:27 +0200
Subject: [PATCH 0/2] clk: exynos-audss: Adapt to exising clock framework
In-Reply-To: <1405071475-31946-1-git-send-email-tushar.b@samsung.com>
References: <1405071475-31946-1-git-send-email-tushar.b@samsung.com>
Message-ID: <53BFB39F.6040606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

On 11.07.2014 11:37, Tushar Behera wrote:
> The patchset is targetted as moving exising exynos-audss clock driver from being
> a module driver. The driver is now registered through CLK_OF_DECLARE and is
> inline with other Samsung clock drivers.

I'm afraid I have to NAK this series or at least the part converting the
driver back to use CLK_OF_DECLARE().

We have deliberately made this driver a platform driver, because this is
how drivers should be modeled in Linux kernel whenever possible.
CLK_OF_DECLARE() should be only considered a hack to work around late
initialization of driver model. Reverting this change without a good
reason (and you haven't provided such) is just going backwards.

Rest of this series is actually quite nice, though, as reusing Samsung
clock helpers reduces the line count significantly, so if you could
rework this to keep this driver a platform driver then we could get
something I could ack.

Best regards,
Tomasz
