From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Sep 2014 17:31:30 +0100
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <2843702.jP4KCB2Kid@wuerfel>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <2961958.2caI26WGbt@wuerfel> <20140903160936.GL3127@leverpostej>
 <2843702.jP4KCB2Kid@wuerfel>
Message-ID: <20140903163130.GM3127@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 05:18:42PM +0100, Arnd Bergmann wrote:
> On Wednesday 03 September 2014 17:09:36 Mark Rutland wrote:
> > On Wed, Sep 03, 2014 at 05:05:51PM +0100, Arnd Bergmann wrote:
> > > On Wednesday 03 September 2014 16:56:55 Mark Rutland wrote:
> > > > Personally I'd like to see such things patched by the firmware/loader
> > > > where possible (ideally with some way of switching said patching off if
> > > > we really know better). We already expect the loader to patch memory
> > > > nodes where memory can be dynamically populated. 
> > > > 
> > > > I don't see why we should tie the in-kernel dts to a particular firmware
> > > > revision. Having such properties in the in-kernel dts is only going to
> > > > mislead. The arm64 boot-wrapper patches dts for PSCI, but for
> > > > compatibility with old wrappers the in-kernel dts must forever say
> > > > spin-table is used to bring up secondaries.
> > > 
> > > But the kernel has never supported this platform with a non-PSCI
> > > enable method, why should we provide compatibility for something
> > > we never had upstream?
> > 
> > I'm not arguing we should.
> > 
> > What I'm suggesting is there wouldn't be an enable-method at all (so we
> > won't bring up secondaries at all unless that's patched).
> 
> Ok, I see the appeal in forcing boot loaders to put some patch
> up the dtbs with whatever software interfaces they provide.
> What I'm interested in however is making it harder for the boot
> loader to use something other than psci.

I see.

I agree that we presently want systems to implement PSCI (0.2+), and we
certainly do not want anything that's platform-specific.

However, I'm not sure I follow the reasoning for making this
significantly harder, and even ignoring that I don't think this does
make things significantly harder. Especially so if we have a PSCI node
but not an enable method -- in that case its trivial to patch in an
unrelated enable-method anyhow.

Mark.
