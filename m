From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Sep 2014 08:49:58 -0700
Subject: [PATCH] clk: ti: change clock init to use generic of_clk_init
In-Reply-To: <541FD5F4.6020909@ti.com>
References: <1408628959-32442-1-git-send-email-t-kristo@ti.com>
 <20140918171725.GL14505@atomide.com>
 <alpine.DEB.2.02.1409191632170.22526@utopia.booyaka.com>
 <541FC714.9050203@ti.com> <541FD5F4.6020909@ti.com>
Message-ID: <20140923154958.GB2451@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140922 00:55]:
> On 09/22/2014 09:52 AM, Tero Kristo wrote:
> >On 09/19/2014 07:33 PM, Paul Walmsley wrote:
> >>On Thu, 18 Sep 2014, Tony Lindgren wrote:
> >>
> >>>* Tero Kristo <t-kristo@ti.com> [140821 06:52]:
> >>>>Previously, the TI clock driver initialized all the clocks
> >>>>hierarchically
> >>>>under each separate clock provider node. Now, each clock that requires
> >>>>IO access will instead check their parent node to find out which IO
> >>>>range
> >>>>to use.
> >>>>
> >>>>This patch allows the TI clock driver to use a few new features
> >>>>provided
> >>>>by the generic of_clk_init, and also allows registration of clock nodes
> >>>>outside the clock hierarchy (for example, any external clocks.)
> >>>
> >>>Paul, any comments on this one?
> >>
> >>Not at this point.
> >
> >Tony, ok to merge this through clock tree?
> 
> Oh btw, this is v1, I posted v2 a week back here:
> 
> http://article.gmane.org/gmane.linux.ports.arm.omap/118551
> 
> v2 has the retry init logic fixed in it (mainly for DPLLs which can have two
> separate parents which of both must be available during init.)

Oh OK. I acked that one so please feel free to merge it via the
clock tree. It does not seem to confilict with anything I have
queued up.

Regards,

Tony
