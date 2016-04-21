From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Apr 2016 14:01:15 +0200
Subject: [PATCH v3 02/19] clk: sunxi: Add display and TCON0 clocks driver
In-Reply-To: <20160415223410.GS14441@codeaurora.org>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-3-git-send-email-maxime.ripard@free-electrons.com>
 <20160415223410.GS14441@codeaurora.org>
Message-ID: <20160421120115.GN13045@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Apr 15, 2016 at 03:34:10PM -0700, Stephen Boyd wrote:
> > +static int sun4i_a10_display_reset_xlate(struct reset_controller_dev *rcdev,
> > +					 const struct of_phandle_args *spec)
> > +{
> > +	/* We only have a single reset signal */
> > +	return 0;
> > +}
> 
> Is there a default function for this case in the reset framework?

No, the reset bindings assumes that you have a cell size of 1, and
it's the only case that's supported by the reset framework default
xlate.

I adressed the rest of your comments.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160421/cfc59e89/attachment.sig>
