From: coelho@ti.com (Luciano Coelho)
Date: Fri, 5 Jul 2013 10:54:13 +0300
Subject: [RFC] clk: add flags to distinguish xtal clocks
In-Reply-To: <20130704231953.10823.94331@quantum>
References: <1372971912-10877-1-git-send-email-coelho@ti.com>
 <20130704222538.10823.2559@quantum>
 <1372977465.21065.136.camel@cumari.coelho.fi>
 <20130704231953.10823.94331@quantum>
Message-ID: <1373010853.21065.159.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-07-04 at 16:19 -0700, Mike Turquette wrote:
> Quoting Luciano Coelho (2013-07-04 15:37:45)
> > On Thu, 2013-07-04 at 15:25 -0700, Mike Turquette wrote:
> > > Or is it the same clock input and basically the problem is that you need
> > > to know what kind of waveform to expect (e.g. square versus sine)?
> > 
> > It's the same clock input in the chip's perspective.  One clock input
> > that can be any of the combinations I mentioned above.  Again, I'm not
> > familiar with clocks, so I guess the square vs. sine explanation is
> > plausible.  What I could see in the firmware is that it handles the
> > clocks differently if they're xtal or not.
> 
> OMAP has a similar thing where sys_clkin (the fast reference clock for
> the chip) can be 19.2, 26, 38.4, etc. This is easy to handle since only
> the rates matter.

Right, this part is easy and I already have the code for that.  What I'm
missing is a way to pass this XTAL flag to the chip.


> In your case you need some extra metadata to know what to do. I'm really
> not sure if CLK_IS_TYPE_XTAL is the most useful form this metadata can
> take. It would be best to know if the waveform is what you really need
> to know, or perhaps something else. For instance you might be affected
> by some clock signal stabilization time. Can you talk to your hardware
> guys and figure it out? I'd rather model the actual needs instead of
> just tossing a flag in there.

I get your point.  I have tried to investigate how this flag is used by
the firmware and I could see that it is used to set different "buffer
gains" and "delays" when waking up (I guess this means when the clock is
starting, so probably related to stabilization time).  They specify two
"modes", "boost" and "normal" and use different delay values for each.

As I said, I don't know almost anything about clocks, so all this
doesn't make much sense to me.  But maybe you can get an idea?

--
Cheers,
Luca.
