From: horms@verge.net.au (Simon Horman)
Date: Fri, 12 May 2017 09:32:30 +0200
Subject: [PATCH v3 1/3] arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
In-Reply-To: <CAMuHMdU0NUFtqDOKnRHQuSXurP6NKy7bNVhBQB-_MOoSrnNpYQ@mail.gmail.com>
References: <1494503934-23367-1-git-send-email-geert+renesas@glider.be>
 <1494503934-23367-2-git-send-email-geert+renesas@glider.be>
 <20170511145329.GD21895@verge.net.au>
 <CAMuHMdU0NUFtqDOKnRHQuSXurP6NKy7bNVhBQB-_MOoSrnNpYQ@mail.gmail.com>
Message-ID: <20170512073229.GC27979@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 05:42:27PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, May 11, 2017 at 4:53 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, May 11, 2017 at 01:58:52PM +0200, Geert Uytterhoeven wrote:
> >> Update r8a7795.dtsi so it corresponds to R-Car H3 ES2.0 or later:
> >>   - The following devices no longer exist on ES2.0, and are thus removed:
> >>     fcpf2, fcpvd3, fcpvi2, fdp1-2, usb3-if1, vspd3, vspi2.
> >>   - The DU <-> VSPD topology is different on ES2.0, hence remove the
> >>     "compatible" and "vsps" properties from the DU node until the driver
> >>     can handle this.
> >>
> >> Move support for the ES1.x revision of the R-Car H3 SoC into a
> >> separate file.  To avoid duplication, r8a7795-es1.dtsi includes
> >> r8a7795.dtsi, add adds/removes/overrides device nodes and properties
> >> where needed.
> >
> > I think the above should be re-worded given your explanation below the
> > scissors that no deletion or overriding occurs.
> 
> I wanted to document clearly what needs to be done in the generic case...
> I agree no removal or override is done right now.
> 
> If you prefer it that way, I can reword it.

I think I would prefer that.

> >> Switch r8a7795-salvator-x.dts and r8a7795-h3ulcb.dts from r8a7795.dtsi
> >> to r8a7795-es1.dtsi to preserve compatibility.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> While currently r8a7795-es1.dtsi only adds device nodes, removal of
> >> devices nodes and properties can be implemented using the /delete-node/
> >> and /delete-property/ keywords, as shown below:
> >>
> >>       &soc {
> >>               /delete-node/ <name>@<addr>;
> >>       };
> >>
> >>       &<label> {
> >>               /delete-property/ <prop>;
> >>       };
> >
> > I would be interested to also see an example of an override and
> > for the examples to be included in the changelog itself.
> 
> You mean above the scissors? ;-)

Yes, that is what I meant.

> Currently we don't have any devices or properties in DT that need removals
> or overrides. Note that I did test those.
> 
> If we add the "vsps" property to the DU node for ES2.0, we can have an
> override for it now.  But we've plenty of experience with letting .dts
> override properties in .dtsi.

Ok, point taken.

> For node deletion, we'll have to wait until someone enables the extra USB
> channels on ES2.0.
> 
> For property deletion, I don't have an actual example in mind, but I wanted
> to be sure that worked in case we ever need it.

I appreciate you taking the time to test deletion.
I think its worth documenting above the scissors.
