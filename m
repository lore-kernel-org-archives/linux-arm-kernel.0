From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 May 2014 22:54:35 +0200
Subject: [linux-sunxi] [PATCH 3/6] clk: sunxi: Move the GMAC clock to a
 file of its own
In-Reply-To: <537124C4.5080303@elopez.com.ar>
References: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399692821-20988-4-git-send-email-maxime.ripard@free-electrons.com>
 <536E5CBB.5070605@elopez.com.ar> <20140512193646.GE17154@lukather>
 <537124C4.5080303@elopez.com.ar>
Message-ID: <20140512205435.GA7100@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 04:45:08PM -0300, Emilio L?pez wrote:
> >>>+	clk = clk_register_composite(NULL, clk_name,
> >>>+			parents, SUN7I_A20_GMAC_PARENTS,
> >>>+			&mux->hw, &clk_mux_ops,
> >>>+			NULL, NULL,
> >>>+			&gate->hw, &clk_gate_ops,
> >>>+			0);
> >>>+
> >>>+	if (IS_ERR(clk))
> >>>+		goto iounmap_reg;
> >>>+
> >>>+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
> >>>+	clk_register_clkdev(clk, clk_name, NULL);
> >>
> >>As I mentioned on the other email, I don't think we are using
> >>clkdev. Maybe we can drop it.
> >
> >No we aren't, but we should not really modify code while moving it. I
> >can send another patch to do so, but that should not prevent this code
> >from going in.
> 
> That would be great :) The patches themselves are okay, I just
> thought I'd mention it so it's not forgotten.

It's not, Boris reminded it to me a week ago :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/19e91e02/attachment.sig>
