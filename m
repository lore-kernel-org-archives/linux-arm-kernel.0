From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 19 Nov 2015 16:43:47 +0100
Subject: [PATCH 05/19] clk: sunxi: add DRAM gates
In-Reply-To: <CAGb2v65qjKCNER=5Gq5UXnvY_nia+EQYRAk3U9hokmXuxHoi_Q@mail.gmail.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66B7X5xQGMq_MzAHGz4OLsnDQStVHcQaMGO+HYY43kjBQ@mail.gmail.com>
 <CAGb2v65qjKCNER=5Gq5UXnvY_nia+EQYRAk3U9hokmXuxHoi_Q@mail.gmail.com>
Message-ID: <20151119154347.GR32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 04:08:53PM +0800, Chen-Yu Tsai wrote:
> On Mon, Nov 9, 2015 at 12:18 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> > On Fri, Oct 30, 2015 at 10:20 PM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> >> The Allwinner SoCs have a gate controller to gate the access to the DRAM
> >> clock to the some devices that need to access the DRAM directly (mostly
> >> display / image related IPs).
> >>
> >> Use a simple gates driver to support it.
> >>
> >> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
> >
> >> ---
> >>  drivers/clk/sunxi/clk-simple-gates.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
> >> index 0214c6548afd..5666c767fa14 100644
> >> --- a/drivers/clk/sunxi/clk-simple-gates.c
> >> +++ b/drivers/clk/sunxi/clk-simple-gates.c
> >> @@ -112,6 +112,8 @@ CLK_OF_DECLARE(sun5i_a13_apb0, "allwinner,sun5i-a13-apb0-gates-clk",
> >>                sunxi_simple_gates_init);
> >>  CLK_OF_DECLARE(sun5i_a13_apb1, "allwinner,sun5i-a13-apb1-gates-clk",
> >>                sunxi_simple_gates_init);
> >> +CLK_OF_DECLARE(sun5i_a13_dram, "allwinner,sun5i-a13-dram-gates-clk",
> >> +              sunxi_simple_gates_init);
> 
> Nit: Since the compatible added is sun5i, could you mention it in the
> commit message,
> to avoid confusion when we do this for the other families?

It will be fixed in the v2.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151119/e0f85642/attachment-0001.sig>
