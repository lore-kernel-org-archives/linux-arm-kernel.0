From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jan 2014 11:17:33 +0000
Subject: AArch64 kernel image decompression
In-Reply-To: <20140110170436.GS8153@joshc.qualcomm.com>
References: <20140110170436.GS8153@joshc.qualcomm.com>
Message-ID: <20140113111733.GD1189@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 05:04:36PM +0000, Josh Cartwright wrote:
> Hey Will-

Hi Josh,

> Scanning the Documentation/arm64/booting.txt document, I came across
> this, listing an optional step a bootloader might take:
> 
> "The AArch64 kernel does not currently provide a decompressor and
> therefore requires decompression (gzip, etc.) to be performed by the
> boot loader if a compressed Image target (e.g. Image.gz) is used."
> 
> Do you envision that, if a decompressor is desired, it will always be
> the responsibility of a bootloader to implement it?

That's certainly our current stance, yes. It also simplifies the booting
code and things like EFI stub, so I'd be reluctant to consider adding a
decompressor to the arm64 kernel without a compelling use-case.

> In other words, would you accept patches adding support for building
> zImages (and others) for AArch64?

Are these patches actually needed, or are you trying to find a project
involving the arm64 kernel? If the latter, I'm sure we can think of plenty
of other things you can work on :)

Will
