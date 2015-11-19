From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 19 Nov 2015 16:42:58 +0100
Subject: [PATCH 01/19] clk: sunxi: Add display clock
In-Reply-To: <20151112203154.GE15032@codeaurora.org>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-2-git-send-email-maxime.ripard@free-electrons.com>
 <20151030212902.GG19782@codeaurora.org>
 <20151106233926.GN6114@lukather>
 <20151112203154.GE15032@codeaurora.org>
Message-ID: <20151119154258.GQ32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 12:31:54PM -0800, Stephen Boyd wrote:
> On 11/06, Maxime Ripard wrote:
> > Hi Stephen,
> > 
> > Thanks for your feedback!
> > 
> > On Fri, Oct 30, 2015 at 02:29:02PM -0700, Stephen Boyd wrote:
> > > > +
> > > > +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> > > > +	if (!mux)
> > > [..]
> > > > +		goto free_reset;
> > > > +	}
> > > > +
> > > > +	return;
> > > > +
> > > > +free_reset:
> > > > +	kfree(reset_data);
> > > > +free_clk:
> > > > +	clk_unregister(clk);
> > > 
> > > We really ought to have a clk_composite_unregister() API.
> > 
> > Can we?
> > 
> > We can always unregister the clock itself, but do we have a way to
> > retrieve the structure that has been allocated in there?
> > 
> > (note that it also applies to the generic clocks registration: muxes,
> > dividers, and so on).
> 
> Yes we have a way. We've done the same sort of design for other
> generic clocks. Do the __clk_get_hw() thing like in clk-divider.c

Ack. I'll cook up a patch for this then.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151119/2f6046ef/attachment.sig>
