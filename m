From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Mon, 13 Jan 2014 11:29:20 +0000
Subject: AArch64 kernel image decompression
In-Reply-To: <20140113111733.GD1189@mudshark.cambridge.arm.com>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <20140113111733.GD1189@mudshark.cambridge.arm.com>
Message-ID: <69dfcb9d142443638e4ccfedd92c4f05@BN1PR03MB220.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Will Deacon
> Sent: Monday, January 13, 2014 4:48 PM
> To: Josh Cartwright
> Cc: Catalin Marinas; linux-arm-kernel at lists.infradead.org
> Subject: Re: AArch64 kernel image decompression
> 
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
> 
> > In other words, would you accept patches adding support for building
> > zImages (and others) for AArch64?
> 
> Are these patches actually needed, or are you trying to find a project
> involving the arm64 kernel? If the latter, I'm sure we can think of
> plenty of other things you can work on :)
> 

With the u-boot bootloader also having AArch64 support now (see [1]), it would
make sense to add the uImage and decompressor support to the AArch64 Makefile in 
Linux kernel as well, so that u-boot can also boot uImages for AArch64 systems
out-off-box.

[1]. http://git.denx.de/?p=u-boot/u-boot-arm.git;a=shortlog;h=refs/heads/aarch64

Regards,
Bhupesh
