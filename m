From: joshc@codeaurora.org (Josh Cartwright)
Date: Mon, 13 Jan 2014 16:10:25 -0600
Subject: AArch64 kernel image decompression
In-Reply-To: <20140113111733.GD1189@mudshark.cambridge.arm.com>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <20140113111733.GD1189@mudshark.cambridge.arm.com>
Message-ID: <20140113221025.GU8153@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 11:17:33AM +0000, Will Deacon wrote:
> On Fri, Jan 10, 2014 at 05:04:36PM +0000, Josh Cartwright wrote:
> > Hey Will-
>
> Hi Josh,
>
> > Scanning the Documentation/arm64/booting.txt document, I came across
> > this, listing an optional step a bootloader might take:
> >
> > "The AArch64 kernel does not currently provide a decompressor and
> > therefore requires decompression (gzip, etc.) to be performed by the
> > boot loader if a compressed Image target (e.g. Image.gz) is used."
> >
> > Do you envision that, if a decompressor is desired, it will always be
> > the responsibility of a bootloader to implement it?
>
> That's certainly our current stance, yes. It also simplifies the booting
> code and things like EFI stub, so I'd be reluctant to consider adding a
> decompressor to the arm64 kernel without a compelling use-case.

Okay, thanks for the clarification.

> > In other words, would you accept patches adding support for building
> > zImages (and others) for AArch64?
> 
> Are these patches actually needed, or are you trying to find a project
> involving the arm64 kernel?

Really, I'm just trying to get a better handle on the difference in
booting requirements for 32-bit and 64-bit ARM kernels.  I haven't yet
determined whether compression is even necessary for our usecase.

If we did find it necessary and you had said "yes, we'd like in-kernel
decompression, but we haven't gotten around to it yet", then we'd likely
go down the path of implementing it.  Anyway, I'm probably getting too
far ahead of myself. :)

Thanks,
   Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
