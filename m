From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 31 Jan 2013 10:54:36 +0000
Subject: [PATCH v3 15/15] ARM: vexpress/dcscb: probe via device tree
In-Reply-To: <alpine.LFD.2.02.1301301239220.6300@xanadu.home>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-16-git-send-email-nicolas.pitre@linaro.org>
 <510838AD.6040700@gmail.com>
 <alpine.LFD.2.02.1301291634140.6300@xanadu.home>
 <CAMpgmWA0CCSRYxSvA1rNDYLo_RD-UavmX7coBXVpC+HEwQaBFg@mail.gmail.com>
 <alpine.LFD.2.02.1301301239220.6300@xanadu.home>
Message-ID: <20130131105436.GA2091@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 12:43:29PM -0500, Nicolas Pitre wrote:
> On Wed, 30 Jan 2013, Achin Gupta wrote:
> 
> > On Tue, Jan 29, 2013 at 9:41 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > On Tue, 29 Jan 2013, Rob Herring wrote:
> > >
> > >> On 01/29/2013 01:51 AM, Nicolas Pitre wrote:
> > >> > +   node = of_find_compatible_node(NULL, NULL, "arm,dcscb");
> > >>
> > >> This needs binding documentation and should be a more specific name. Not
> > >> knowing what dcscb is, I don't have a suggestion.

The name is 100% specific.  The real problem seems to be that it's also
very cryptic, and undocumented.

> > >
> > > Yes, I mentioned in the cover page that DT bindings are not yet
> > > documented.
> > >
> > > DCSCB stands for "Dual Cluster System Control Block".  This is in fact a
> > > set of miscellaneous registers, mainly for reset control of individual
> > > CPUs and clusters.
> > >
> > >> Perhaps should include vexpress or specific core tile name it is part
> > >> of.
> > >
> > > /me hopes for some ARM dude more acquainted with their nomenclature to
> > > chime in with suggestions.
> > >
> > 
> > As nico said, the DCSCB is just a reset controller thats a part of the
> > FastModels implementation.  The implementation should be referred to as
> > VE bL RTSM. The official name goes by:
> > 
> > RTSM_VE_Cortex-A15x4-A7x4
> > RTSM_VE_Cortex-A15x1-A7x1
> > 
> > The file should be renamed as bL_rtsm.c or something similar.
> 
> I don't think the file name is a problem.  Actually, going with 
> bL_rtsm.c is rather too generic for what itcovers.
> 
> It's the actual device tree binding name that I'd need suggestions for.

We could go for a slightly more generic, informative name like

	arm,dcscb-system-controller

Any views on that?

I think the most important thing is to document the binding, though.

As discussed, this thing appears in the fast models, but we don't
anticipate its being used in real SoCs because they will usually need
something more sophisticated.

Cheers
---Dave
