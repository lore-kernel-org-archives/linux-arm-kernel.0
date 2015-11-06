From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Nov 2015 15:39:26 -0800
Subject: [PATCH 01/19] clk: sunxi: Add display clock
In-Reply-To: <20151030212902.GG19782@codeaurora.org>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-2-git-send-email-maxime.ripard@free-electrons.com>
 <20151030212902.GG19782@codeaurora.org>
Message-ID: <20151106233926.GN6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for your feedback!

On Fri, Oct 30, 2015 at 02:29:02PM -0700, Stephen Boyd wrote:
> > +
> > +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> > +	if (!mux)
> [..]
> > +		goto free_reset;
> > +	}
> > +
> > +	return;
> > +
> > +free_reset:
> > +	kfree(reset_data);
> > +free_clk:
> > +	clk_unregister(clk);
> 
> We really ought to have a clk_composite_unregister() API.

Can we?

We can always unregister the clock itself, but do we have a way to
retrieve the structure that has been allocated in there?

(note that it also applies to the generic clocks registration: muxes,
dividers, and so on).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/4c1b70b4/attachment-0001.sig>
