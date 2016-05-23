From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 May 2016 18:11:59 +0100
Subject: [PATCH v3 4/4] documentation: Add secure monitor binding
 documentation
In-Reply-To: <20160523165931.GA31299@mephisto>
References: <1464021024-29380-1-git-send-email-carlo@caione.org>
 <1464021024-29380-5-git-send-email-carlo@caione.org>
 <20160523163815.GE4976@leverpostej>
 <20160523165931.GA31299@mephisto>
Message-ID: <20160523171159.GH4976@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 06:59:31PM +0200, Carlo Caione wrote:
> On 23/05/16 17:38, Mark Rutland wrote:
> > > +Required properties for the secure monitor node:
> > > +- compatible: Should be "amlogic,meson-sm"
> > > +- amlogic,sm-cmd-input-base: SMC32 function identifier to read the physical
> > > +                             address of the input buffer
> > > +- amlogic,sm-cmd-output-base: SMC32 function identifier to read the physical
> > > +                              address of the output buffer
> > 
> > Do the IDs for these actually differ per board?
> 
> I expect these to differ per SoC (GXBB in this case), not per board. The
> driver is generic enough to be (hopefully) used for several SoCs just
> changing the related header file that defines the SCM commands.
> 
> > Are some functions simply not implemented on some boards?
> 
> I don't think this is possible.

Given that, I think it may be better to just have a
"amlogic,meson-gxbb-sm" compatible string, and derive the set of
functions and associated IDs from that.

That is, unless you know that future revisions have functions with the
exact same semantics but differing IDs.

Regardless, it would make sense to have a GXBB-specific compatible
string prepended to the list. That way in the future we can handle
anything specific to the GXBB variant of the secure monitor if
necessary.

Thanks,
Mark.
