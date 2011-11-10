From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 10 Nov 2011 11:57:57 +0100
Subject: [RFC PATCH] Generic clock parent enumeration
In-Reply-To: <20111110023716.GA11045@b20223-02.ap.freescale.net>
References: <20111104175908.GA9337@glitch>
 <20111110023716.GA11045@b20223-02.ap.freescale.net>
Message-ID: <20111110105757.GA5169@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 10:37:18AM +0800, Richard Zhao wrote:
> On Fri, Nov 04, 2011 at 06:59:08PM +0100, Domenico Andreoli wrote:
> > 
> > The basic idea is that only the clock can provide a way to walk all
> > the parent clocks that it can be attached to. This has multiple purposes:
> > 
> >  1. generic clock framework is able to find the best parent a given
> >     clock can be attached to in order to satisfy an arbitrary requirement
> >     (ie the lowest number of enabled parent clocks, energy constrains,
> >     clock network tuning, etc)
>
> Is there any use case that you have to let clk core select parent?
> In my opinion, clk parent don't change frequently. most time display
> driver do that, which must has ideas of clk tree topology.

If there is not such case then I don't see the need of a generic set
parent at all.

> >  2. generic clock framework is able to check in an implementation
> >     independent way if a given clock is suitable to be parent of
> >     another one
>
> Only mux clk driver needs it.

I think that OF may want to attach nodes to their parents and detect
topology errors without knowing the inner details.

> Richard

thanks,
Domenico
