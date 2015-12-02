From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 2 Dec 2015 10:26:55 +0000
Subject: arm64 boot requirements
In-Reply-To: <565E1A8E.8000506@codeaurora.org>
References: <565BAA2E.5090102@cog.systems> <20151201110159.GA4757@leverpostej>
 <CAKv+Gu_2ufc_q5OsGDsGUqfEieCHc++-r2zxrpDpHcMbZyS_aQ@mail.gmail.com>
 <565E1A8E.8000506@codeaurora.org>
Message-ID: <20151202102655.GA21365@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 05:09:18PM -0500, Christopher Covington wrote:
> On 12/01/2015 06:52 AM, Ard Biesheuvel wrote:
> > However, I strongly feel that the Image header should remain the
> > authoritative source of information regarding the nature (big/little
> > endian, page size) and the static footprint of the Image.
> 
> I find `readelf -a | less` quite handy. Is there anything comparable for
> the AArch64 Image format?

Not that I am aware of. These days I just use od or hexedit, and parse
the header manually.

It's documented, so it would be possible to write one.

> Please forgive my ignorance, but is the EFI stub another possible source
> for sort of information?

Not really. The PE/COFF header for the EFI stub realistically only tells
you wether or not the kernel has an EFI stub. It shouldn't be used to
derive information about the kernel itself.

Thanks,
Mark.
