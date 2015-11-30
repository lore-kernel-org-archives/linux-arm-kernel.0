From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Nov 2015 21:14:12 +0100
Subject: [PATCH] clk: sunxi: pll2: Fix clock running too fast
In-Reply-To: <20151130193216.GI11298@codeaurora.org>
References: <1448897699-20475-1-git-send-email-maxime.ripard@free-electrons.com>
 <20151130193216.GI11298@codeaurora.org>
Message-ID: <20151130201412.GA29263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 11:32:16AM -0800, Stephen Boyd wrote:
> On 11/30, Maxime Ripard wrote:
> > @@ -191,25 +186,17 @@ err_unmap:
> >  	iounmap(reg);
> >  }
> >  
> > -static struct sun4i_pll2_data sun4i_a10_pll2_data = {
> > -	.pre_div_flags	= CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
> > -};
> > -
> >  static void __init sun4i_a10_pll2_setup(struct device_node *node)
> >  {
> > -	sun4i_pll2_setup(node, &sun4i_a10_pll2_data);
> > +	sun4i_pll2_setup(node, &sun4i_a10_pll2_data, 0);
> 
> And it doesn't compile, because we just deleted the data that
> this is taking an address of. Hmph.

Sorry for the screw up, I'll resend a new version tomorrow...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/10f70392/attachment-0001.sig>
