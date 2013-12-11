From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Dec 2013 17:09:03 +0000
Subject: [PATCH 3/6] arm64: dts: Add a devicetree for the ARMv8 4xA53
 4xA57 FVP
In-Reply-To: <CAD0U-hJABMzEXrjN1r1EuynwSGX+K=KdVRcj8gXkdZrXeMmx-w@mail.gmail.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-3-git-send-email-broonie@kernel.org>
 <20131211135536.GC17681@e106331-lin.cambridge.arm.com>
 <20131211141148.GV11468@sirena.org.uk>
 <20131211150433.GD17681@e106331-lin.cambridge.arm.com>
 <1386778133.3447.6.camel@linaro1.home>
 <CAD0U-hJABMzEXrjN1r1EuynwSGX+K=KdVRcj8gXkdZrXeMmx-w@mail.gmail.com>
Message-ID: <20131211170903.GF17681@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 04:41:32PM +0000, Ryan Harkin wrote:
> On 11 December 2013 16:08, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> > On Wed, 2013-12-11 at 15:04 +0000, Mark Rutland wrote:
> >> On Wed, Dec 11, 2013 at 02:11:48PM +0000, Mark Brown wrote:
> >> > On Wed, Dec 11, 2013 at 01:55:36PM +0000, Mark Rutland wrote:
> >> > > On Wed, Dec 11, 2013 at 01:13:23PM +0000, Mark Brown wrote:
> > [...]
> >> >
> >> > > > +/ {
> >> > > > +       model = "FVP Base";
> >> >
> >> > > FVP Base (is as the name implies) a base upon which particular model
> >> > > instances are built. This name should be clarified (e.g. "FVP Base A57x4
> >> > > A53x4").
> >> >
> >> > > That also applies to the filename.
> 
> This same file is used to boot the AEMv8 architectural model as well
> as the Cortex A57-A73 model, so I think someone would need to find
> another filename that makes sense in both contexts.
> 
> I guess that using the same file for two models could in itself be a
> problem solved via includes and simpler wrappers.

We should have a base platform dtsi that describes the standard devices
and memory map.

Individual variants can include the dtsi and describe the model name and
compatible string, CPUs, variant-specific devices, and firmware details.

While the same DT will work regardless of cpu type currently, it's
relatively easy to factor that out anyway.

> 
> But as Mark Brown says, ARM have originated this file and personally
> I'd rather it was changed in the ARM Trusted Firmware repo first and
> propagated here.

I completely agree that the DTs in the Trusted Firmware repo should be
corrected. I will try to get them fixed.

> 
> To answer another question from earlier: there is no direct
> correlation between the ARM Trusted Firmware and the device tree files
> other than the same repo hosts both files.  Trusted firmware does not
> build or embed the DTBs.  UEFI is currently what loads the DTB and
> passes it to the kernel.  And that isn't part of the trusted firmware
> repo, of course.

There _is_ a direct correlation between the trusted firmware and the DT;
the psci node describes the Trusted Firmware PSCI implementation. If you
don't use the Trusted Firmware then you need a different DT.

However, this would only be a platform variant built atop of the more
common FVP Base, so most of the DT can be shared.

Thanks,
Mark.
