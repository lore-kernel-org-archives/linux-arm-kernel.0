From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Nov 2015 16:11:09 -0800
Subject: [PATCH 04/19] clk: sunxi: Add TCON channel1 clock
In-Reply-To: <20151030213734.GI19782@codeaurora.org>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-5-git-send-email-maxime.ripard@free-electrons.com>
 <20151030213734.GI19782@codeaurora.org>
Message-ID: <20151107001109.GQ6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 30, 2015 at 02:37:34PM -0700, Stephen Boyd wrote:
> On 10/30, Maxime Ripard wrote:
> > The TCON is a controller generating the timings to output videos signals,
> > acting like both a CRTC and an encoder.
> > 
> > It has two channels depending on the output, each channel being driven by
> > its own clock (and own clock controller).
> > 
> > Add a driver for the channel 1 clock.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Similar comments apply to patches 3 and 4. Was the same code
> copy/pasted two more times and then changed to have different
> values?

I don't really recall, but I probably used the same skeleton yeah.

> Looks like we should consolidate all that stuff into something more
> generic so that we don't have the same problems 3 times.

Does it?

They're both pretty different actually. One is a gate + mux + reset
(patch 3), the other one is actually a combination of two clocks, one
that is the parent of the other, the former being a gate + mux, the
latter a gate + div.

At least at the hardware level, they're very different, and adding
more code to deal with both case would complicate quite a lot the
probe code, for no real reasons.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/7b03f575/attachment.sig>
