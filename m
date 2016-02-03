From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Feb 2016 18:40:18 +0000
Subject: [PATCH] dt-bindings: arm, gic-v3: require that reserved cells are
 always 0
In-Reply-To: <20160203182054.GH1234@leverpostej>
References: <1454522458-29643-1-git-send-email-will.deacon@arm.com>
 <20160203182054.GH1234@leverpostej>
Message-ID: <20160203184017.GA15852@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 06:20:54PM +0000, Mark Rutland wrote:
> On Wed, Feb 03, 2016 at 06:00:58PM +0000, Will Deacon wrote:
> > Consequently, any extensions to the PPI or SPI interrupt specifiers must
> > be able to work with random crap from legacy DTs, effectively
> > necessitating a new interrupt type in the first cell. Sigh.
> 
> I'm not sure that's true if we allocate a new value for the 1st cell for
> "extended" PPI or SPI interrupt-sepcficiers (which presumably add
> restrictions). That would also allow old kernels to safely skip such
> interrupts rather than mis-parsing them.

Right, that's what I said :)

> > This patch fixes the text so that additional, reserved cells are
> > required to be zero. This looks like a reasonable thing to require and
> > is already satisifed by the .dts files in-tree.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> This patch itself makes sense, so FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Any proposed extention to the binding requires its own discussion.

Yup.

Marc -- can you queue this please?

Will
