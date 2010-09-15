From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Wed, 15 Sep 2010 11:15:55 +0300
Subject: [PATCH 0/3] Common struct clk implementation, v7
In-Reply-To: <1284522014.516876.675872472687.0.gpush@pororo>
References: <1284522014.516876.675872472687.0.gpush@pororo>
Message-ID: <4C9080BB.3090703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2010 06:40 AM, Jeremy Kerr wrote:
> Hi all,
>
> These patches are an attempt to allow platforms to share clock code. At
> present, the definitions of 'struct clk' are local to platform code,
> which makes allocating and initialising cross-platform clock sources
> difficult, and makes it impossible to compile a single image containing
> support for two ARM platforms with different struct clks.
>
> The two patches are for the architecture-independent kernel code,
> introducing the common clk infrastructure. The changelog for the first
> patch includes details about the new clock definitions.
>
> As requested by rmk, I've put together a small series of patches
> illustrating the usage of the common struct clock on the ARM imx51
> platform. These are available in my git tree:
>
>   git://kernel.ubuntu.com/jk/dt/linux-2.6
>
> in the clk-common-mx51 branch (clk-common..clk-common-mx51). There is
> also a port  for versatile (clk-common-versatile) in this tree too.
>
> The approach I've taken with the imx51 port is to temporarly duplicate
> the platform-common clock code (ie, for all mxc-based boards) to enable
> usage of the common struct clk on one machine (imx51), while leaving the
> others as-is. For a proper platform-wide usage of the common struct clk,
> we'd be better off doing the whole platform at once. However, mx51 is
> the only mxc-based HW I have, hence the duplicated example port.
>
> In the example port, the first change simply converts the mxc's struct
> clk to a struct clk_mxc, using the new API.  The subsequent patches move
> certain clocks to more specific data structures (eg clk_fixed and
> clk_pll) where possible.
>
> Ben Herrenschmidt is looking at using common struct clk code for powerpc
> too, hence the kernel-wide approach.
>
> Many thanks to the following for their input:
>   * Ben Dooks<ben-linux@fluff.org>
>   * Baruch Siach<baruch@tkos.co.il>
>   * Russell King<linux@arm.linux.org.uk>
>   * Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
>   * Lorenzo Pieralisi<Lorenzo.Pieralisi@arm.com>

Funny enough, this morning on my way to work I was thinking exactly
about the same issue! I was very surprised to discover that you just
did it :)

Acked-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
