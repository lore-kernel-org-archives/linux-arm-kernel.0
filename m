From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Jul 2012 16:53:03 +0100
Subject: [PATCH 1/9] ARM: vexpress: remove automatic errata workaround
 selection
In-Reply-To: <4FFD9F7F.7020103@gmail.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-2-git-send-email-pawel.moll@arm.com>
 <4FFD956D.7020901@gmail.com>
 <20120711151846.GE13498@mudshark.cambridge.arm.com>
 <4FFD9F7F.7020103@gmail.com>
Message-ID: <20120711155303.GF13498@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 04:45:03PM +0100, Rob Herring wrote:
> On 07/11/2012 10:18 AM, Will Deacon wrote:
> > The problem I have with the current scheme for vexpress is that you can't
> > disable the workarounds when you know they are not needed. The Kconfig
> > *forces* them to be enabled -- that's certainly not right. Of the
> > workarounds in question, ARM_ERRATA_720789 is not runtime enabled and I
> > would like to deselect if when running on my A5, A7 or A15 cores. The
> > description clearly states it's an A9 erratum, so I don't think users will
> > have any difficulty knowing that they don't need it for other cores
> > (although I agree that it should be enabled for single zimage).
> > 
> > The defconfig changes were just a courtesy to reflect the change in the
> > Kconfig, I'm happy for them to be dropped.
> 
> It's not a courtesy. It's the only place it remains documented other
> than git history.

Sorry, I also meant to say that we could select them for the CA9X4 platform,
so the information wouldn't be lost.

> What if you just make the existing config option user selectable?

I think that's harder than it sounds. How would you do this without adding
vexpress-specific dependencies to the erratum config option itself? I
suppose you could make them default y for multi-platform kernels (I can't
remember if Arnd's single zImage changes had a config option for that).

> That doesn't solve the problem with this errata. Obviously on my newer
> A9, I wouldn't want this errata enabled either (assuming there is
> measurable impact). So we should come up with a better solution for
> single kernel image.

Agreed, and I think that's a discussion we should have with a wider
audience. For some of the simpler workarounds we could probably use code
patching like we do for the SMP/UP stuff and like (I think) powerpc does
too.

Will
