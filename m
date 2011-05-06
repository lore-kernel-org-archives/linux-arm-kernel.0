From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 6 May 2011 11:36:31 -0600 (MDT)
Subject: Common clock and dvfs
In-Reply-To: <BANLkTik+LRWvJzppof1zngdrZEPXzMc_UQ@mail.gmail.com>
References: <4DC07F10.6010305@ti.com> <4DC230E0.7090909@ti.com>
	<BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
	<4DC311C6.7090707@ti.com>
	<BANLkTik+LRWvJzppof1zngdrZEPXzMc_UQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1105061100460.30136@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Not that this is particularly related to DVFS, but:

On Thu, 5 May 2011, Colin Cross wrote:

> On Thu, May 5, 2011 at 2:08 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
>
> > Colin Cross wrote:
> 
> >> omap_hwmod is entirely omap specific, and any generic solution cannot
> >> be based on it.
> >
> > For the moment, because it is a fairly new design, but nothing should
> > prevent us to make it generic if this abstraction is relevant for other SoC.
> 
> That's not how you design abstractions.

Oh really?

> You can't abstract one case, without considering other SoCs, and then 
> make it generic if it fits other SoCs - it will never fit other SoCs.  
> You have to consider all the cases you want it to cover, and design an 
> abstraction that makes sense for the superset.

In actual practice, one often does not know in advance the entire universe 
of cases that one needs to cover.  Even just for one SoC.

Consider that you mentioned earlier that you had to rewrite the Tegra 
clock code several times.  Now, add several other families of SoCs to the 
requirements.  If the documentation for these chips is even available at 
all, it is often misleading or wrong.

Attempting to create an abstraction before one knows the underlying 
requirements of what one is actually trying to abstract is a plan for 
intense suffering.  There's little glory in it.

...

In the specific case of omap_hwmod, the core of the omap_hwmod data 
structures were designed such that they could apply to any SoC with a 
complex interconnect.  The design was based on hardware principles common 
to any SoC: interconnects, IP blocks, reset lines, etc.  There are 
OMAP-specific parts, but if others found omap_hwmod useful, they're 
trivial to abstract.  We haven't sought to force it on others.


- Paul
