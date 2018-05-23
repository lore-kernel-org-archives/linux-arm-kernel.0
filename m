From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 May 2018 16:40:57 +0100
Subject: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
References: <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org>
 <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
 <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
 <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
 <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <20180523082908.GB4828@sirena.org.uk>
 <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
Message-ID: <20180523154057.GL4828@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 08:23:22AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 23, 2018 at 1:29 AM, Mark Brown <broonie@kernel.org> wrote:
> 
> > It's arguable either way - you could say that the client gets to specify
> > a safe range at all times or you could say that the machine constraints
> > should cover all cases where the hardware is idling.  Of course RPMh
> > is missing anything like the machine constraints (as we can see from all
> > the fixing up of undesirable hard coding we have to do) so it's kind of
> > pushed towards the first case.

> OK, fair enough.  If others all agree that it's OK to make requests
> about the voltage of a disabled regulator then I won't stand in the
> way.  I guess it does call into question the whole idea of caching /
> not sending the voltage until the first enable because it means
> there's no way for the client to use this feature until they've
> enabled / disabled the regulator once.  If you think of it as invalid
> to adjust the voltage of a disabled regulator then the caching
> argument is super clean, but once you say that you should normally be

It's got to be valid to think about the voltage of a disabled regulator
since drivers want to be able make sure that the regulator gets enabled
with a sensible config.  With most hardware this is really easy since
you can just look at the status reported by the hardware but the RPM
makes this hard since there's so much write only stuff in there.

> able to do it it feels more like a hacky workaround.  ...but I suppose
> that's what we've got to live with...

These RPM systems are always going to have problems of some kind
unfortunately unless the interface changes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180523/9671d53b/attachment.sig>
