From: ryan.harkin@linaro.org (Ryan Harkin)
Date: Wed, 11 Dec 2013 16:41:32 +0000
Subject: [PATCH 3/6] arm64: dts: Add a devicetree for the ARMv8 4xA53
 4xA57 FVP
In-Reply-To: <1386778133.3447.6.camel@linaro1.home>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-3-git-send-email-broonie@kernel.org>
 <20131211135536.GC17681@e106331-lin.cambridge.arm.com>
 <20131211141148.GV11468@sirena.org.uk>
 <20131211150433.GD17681@e106331-lin.cambridge.arm.com>
 <1386778133.3447.6.camel@linaro1.home>
Message-ID: <CAD0U-hJABMzEXrjN1r1EuynwSGX+K=KdVRcj8gXkdZrXeMmx-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 December 2013 16:08, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> On Wed, 2013-12-11 at 15:04 +0000, Mark Rutland wrote:
>> On Wed, Dec 11, 2013 at 02:11:48PM +0000, Mark Brown wrote:
>> > On Wed, Dec 11, 2013 at 01:55:36PM +0000, Mark Rutland wrote:
>> > > On Wed, Dec 11, 2013 at 01:13:23PM +0000, Mark Brown wrote:
> [...]
>> >
>> > > > +/ {
>> > > > +       model = "FVP Base";
>> >
>> > > FVP Base (is as the name implies) a base upon which particular model
>> > > instances are built. This name should be clarified (e.g. "FVP Base A57x4
>> > > A53x4").
>> >
>> > > That also applies to the filename.

This same file is used to boot the AEMv8 architectural model as well
as the Cortex A57-A73 model, so I think someone would need to find
another filename that makes sense in both contexts.

I guess that using the same file for two models could in itself be a
problem solved via includes and simpler wrappers.

But as Mark Brown says, ARM have originated this file and personally
I'd rather it was changed in the ARM Trusted Firmware repo first and
propagated here.

To answer another question from earlier: there is no direct
correlation between the ARM Trusted Firmware and the device tree files
other than the same repo hosts both files.  Trusted firmware does not
build or embed the DTBs.  UEFI is currently what loads the DTB and
passes it to the kernel.  And that isn't part of the trusted firmware
repo, of course.


>> >
>> > I can update these, though they do seem to come from what you guys are
>> > releasing - you might want to follow up on this internally (this applies
>> > to almost all of your review comments, sorry).  It's probably going to
>> > be a bit confusing for users to have the filename change but ho hum :/
>>
>> I'll try to chase up the issues, thanks for making me aware.
>>
>> I don't see the name issue as a big problem. This DT has never been part
>> of the kernel tree, so there's no filename compatibility issue to deal
>> with. Existing users of the DT will already have to be modified to get
>> the DTs from a new source.
>>
>> There should be nothing hanging off the compatible string for the
>> platform yet -- we have no board files or platform blobs in the arm64
>> port. If the model name is being used as anything other than a handy
>> indicator to users, then that's broken anyway.
>
> I believe Android uses model names to determine the filenames of init
> scripts to run. That's not a kernel problem, but thought I would point
> out one 'broken' use that I have first hand experience of, having been
> tripped up before by ARM's twice yearly lets-rename-everything-again
> exercise ;-)
>
> --
> Tixy
>
>
>
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
