From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Jun 2016 16:33:18 -0500
Subject: [PATCH 1/2] Documentation: bindings: Add DT bindings for ARM's
 FVP models.
In-Reply-To: <1466516312.2856.27.camel@linaro.org>
References: <1466424796-13769-1-git-send-email-tixy@linaro.org>
 <20160621132257.GA2263@rob-hp-laptop>
 <1466516312.2856.27.camel@linaro.org>
Message-ID: <20160621213318.GA32655@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 02:38:32PM +0100, Jon Medhurst (Tixy) wrote:
> On Tue, 2016-06-21 at 08:22 -0500, Rob Herring wrote:
> > > +Required properties (in root node):
> > > +- compatible value:
> > > +     compatible = "arm,<family>,<variant>", "arm,<family>";
> > > +  where <family> is one of:
> > > +  - "fvp-base" for the Base FVP
> > > +  - "fvp-ve" for the VE FVP
> > > +  and <variant> is the part of the model's executable filename with
> > the family
> > > +  name omitted, converted to lower case, and with non-alphanumeric
> > characters
> > > +  replaced with '-'. E.g. the Base FVP that has two AEMv8 CPU
> > clusters has an
> > > +  executable file called FVP_Base_AEMv8A-AEMv8A, so the compatible
> > value for
> > 
> > Naming conventions of the exe aren't going to change?
> 
> Almost certainly will at some point, as will the very name Fixed Virtual
> Platform, what 'families' ARM produce and their naming, and the
> configuration of the 'hardware' compiled into the models.
> 
> These are software models, so can be changed easily at the whim of
> marketing, or current perceived requirements from engineers and
> managers. So generally, it's a moving target, that doesn't fit nicely
> into the needs producing device-trees.

Then do we even need to specify something so specific? The kernel 
probably doesn't even care. Are you going to upstream new strings 
everytime there's a new one (that's public)?

We've had models supported upstream for a long time. What's changed now?

Rob
