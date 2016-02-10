From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 10 Feb 2016 16:06:43 +0100
Subject: [linux-sunxi] Re: [PATCH v3 1/5] clk: sunxi: Add apb0 gates for H3
In-Reply-To: <20160210071713.GA19622@box2.japko.eu>
References: <1454542430-16572-1-git-send-email-k@japko.eu>
 <1454542430-16572-2-git-send-email-k@japko.eu>
 <20160204154752.4df7808be3364a98c496c030@free.fr>
 <20160205111152.GA31506@lukather>
 <20160205115837.GD12071@box2.japko.eu>
 <20160209171040.GR31506@lukather>
 <20160210071713.GA19622@box2.japko.eu>
Message-ID: <20160210150643.GG31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 10, 2016 at 08:17:14AM +0100, Krzysztof Adamski wrote:
> On Tue, Feb 09, 2016 at 06:10:40PM +0100, Maxime Ripard wrote:
> >>>>It seems that the other compatible strings are there for historical
> >>>>reasons. Why do you need a new one with such a specific name?
> >>>>
> >>>>It would have been more sensible to add a generic compatible string as
> >>>>"allwinner,apb-gates", letting the removal of the other strings for a
> >>>>later patch...
> >>>
> >>>Yeah, it's a good idea, and it's probably time that we move to that.
> >>>
> >>>However, I'd like to keep per-soc and per-clocks compatibles in the
> >>>DT, in case we need to protect a clock in the future. That doesn't
> >>>prevent to have two compatibles thoughe, the specific and the generic.
> >>>
> >>
> >>So now I'm not sure what you mean. You suggest that I should keep using
> >>specific (sun8i_h3_apb0) or change to generic (apb-gates) in my patch?
> >
> >Both.
> >
> >To have something like that:
> >
> >compatible = "allwinner,sun8i-h3-apb0-gates-clk", "allwinner,sun4i-a10-gates-clk";
> >
> >sun4i-a10-gates-clk being the generic compatible that we would use,
> >and we can always match against the h3 specific compatible if we need
> >to have a different behaviour.
> 
> This seems like a good idea to me but since this is new thing anyways (other
> sunxi SoCs don't do this right now) shouldn't we introduce other
> more generic name for generic clock (like "allwinner,apb-gates" mentioned
> earlier, or maybe "allwinner,simple-apb-gates")?

This is not specific to the APB bus, and the earlier SoC that
introduced those kind of clocks was the A10, hence why I was
suggesting that compatible (since we generally try to use the SoC that
introduced that hardware block in the compatible name).

> Also, wouldn't this be cleaner if I use only specific compatible string
> right now and provide separate patch that adds generic compatible string to
> all current SoCs at once? The downside of this is that it's easier to get
> merge conflicts unless I wait for applying this patchset.

I'd prefer if you added the generic one and were using it in your
subsequent patches. We can always mass convert the existing drivers
later on.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160210/edc4c658/attachment.sig>
