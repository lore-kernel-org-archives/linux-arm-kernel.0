From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 30 Jan 2013 12:43:29 -0500 (EST)
Subject: [PATCH v3 15/15] ARM: vexpress/dcscb: probe via device tree
In-Reply-To: <CAMpgmWA0CCSRYxSvA1rNDYLo_RD-UavmX7coBXVpC+HEwQaBFg@mail.gmail.com>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-16-git-send-email-nicolas.pitre@linaro.org>
 <510838AD.6040700@gmail.com> <alpine.LFD.2.02.1301291634140.6300@xanadu.home>
 <CAMpgmWA0CCSRYxSvA1rNDYLo_RD-UavmX7coBXVpC+HEwQaBFg@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1301301239220.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013, Achin Gupta wrote:

> On Tue, Jan 29, 2013 at 9:41 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 29 Jan 2013, Rob Herring wrote:
> >
> >> On 01/29/2013 01:51 AM, Nicolas Pitre wrote:
> >> > +   node = of_find_compatible_node(NULL, NULL, "arm,dcscb");
> >>
> >> This needs binding documentation and should be a more specific name. Not
> >> knowing what dcscb is, I don't have a suggestion.
> >
> > Yes, I mentioned in the cover page that DT bindings are not yet
> > documented.
> >
> > DCSCB stands for "Dual Cluster System Control Block".  This is in fact a
> > set of miscellaneous registers, mainly for reset control of individual
> > CPUs and clusters.
> >
> >> Perhaps should include vexpress or specific core tile name it is part
> >> of.
> >
> > /me hopes for some ARM dude more acquainted with their nomenclature to
> > chime in with suggestions.
> >
> 
> As nico said, the DCSCB is just a reset controller thats a part of the
> FastModels implementation.  The implementation should be referred to as
> VE bL RTSM. The official name goes by:
> 
> RTSM_VE_Cortex-A15x4-A7x4
> RTSM_VE_Cortex-A15x1-A7x1
> 
> The file should be renamed as bL_rtsm.c or something similar.

I don't think the file name is a problem.  Actually, going with 
bL_rtsm.c is rather too generic for what itcovers.

It's the actual device tree binding name that I'd need suggestions for.


Nicolas
