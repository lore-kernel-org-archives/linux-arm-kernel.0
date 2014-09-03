From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Sep 2014 17:09:36 +0100
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <2961958.2caI26WGbt@wuerfel>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <9081864.6l1AHRQ5bg@wuerfel> <20140903155654.GK3127@leverpostej>
 <2961958.2caI26WGbt@wuerfel>
Message-ID: <20140903160936.GL3127@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 05:05:51PM +0100, Arnd Bergmann wrote:
> On Wednesday 03 September 2014 16:56:55 Mark Rutland wrote:
> > I had asked for the FW to patch up the enable-method (and omit this in
> > the in-kernel dts) as this is something that may vary over the lifetime
> > of the SoC independently from the fixed HW properties (it's a firmware
> > property really).
> 
> I agree in principle.

Ok.
 
> > Personally I'd like to see such things patched by the firmware/loader
> > where possible (ideally with some way of switching said patching off if
> > we really know better). We already expect the loader to patch memory
> > nodes where memory can be dynamically populated. 
> > 
> > I don't see why we should tie the in-kernel dts to a particular firmware
> > revision. Having such properties in the in-kernel dts is only going to
> > mislead. The arm64 boot-wrapper patches dts for PSCI, but for
> > compatibility with old wrappers the in-kernel dts must forever say
> > spin-table is used to bring up secondaries.
> 
> But the kernel has never supported this platform with a non-PSCI
> enable method, why should we provide compatibility for something
> we never had upstream?

I'm not arguing we should.

What I'm suggesting is there wouldn't be an enable-method at all (so we
won't bring up secondaries at all unless that's patched).

I didn't spot an enable-method in skimming this series, but I've not yet
looked at this posting in-depth. Assuming there isn't one I don't see
that we're providing compatibility with anything.

Mark.
