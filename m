From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 11 Mar 2016 17:28:58 +0100
Subject: [PATCH v2 3/5] dmaengine: sun6i: Add 4 as a possible burst value
In-Reply-To: <20160311120601.GD8418@lukather>
References: <cover.1457695169.git.moinejf@free.fr>
 <7898ac737e1cce9542de662f1266d94bd451659e.1457695169.git.moinejf@free.fr>
 <20160311120601.GD8418@lukather>
Message-ID: <20160311172858.6cffb492a18da7da76e7ed94@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Mar 2016 13:06:01 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Fri, Mar 11, 2016 at 12:01:29PM +0100, Jean-Francois Moine wrote:
> > Some DMA transfers, as for H3 audio, ask for 4 as a burst value.
	[snip]
> > @@ -238,6 +238,8 @@ static inline s8 convert_burst(u32 maxburst)
> >  	switch (maxburst) {
> >  	case 1:
> >  		return 0;
> > +	case 4:
> > +		return 1;
> 
> This is true only for the H3.
> 
> For the other SoCs that we support, the only valid values are 0 and 2,
> so we need to reject those values.
> 
> We should do that based on the compatible.
> 
> The easiest solution would be to expose the available burst sizes in
> the probe, and just our new one if we match that compatible, and any
> invalid burst size would be rejected by the framework. Vinod, any
> objection to that?

Do you think that we should also check if the requested ports are
valid, i.e. have a list/bitmap of the possible input/output ports per
SoC, instead of just only the ID of the max port?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
