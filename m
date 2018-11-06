From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Nov 2018 21:34:07 +0000
Subject: [PATCH 0/4] arm/efi: fix memblock reallocation crash due to
 persistent reservations
In-Reply-To: <20181106113732.16351-1-ard.biesheuvel@linaro.org>
References: <20181106113732.16351-1-ard.biesheuvel@linaro.org>
Message-ID: <20181106213406.GB31298@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Tue, Nov 06, 2018 at 12:37:28PM +0100, Ard Biesheuvel wrote:
> This series addresses the kexec/kdump crash on arm64 system with many CPUs
> that was reported by Bhupesh.
> 
> Patches #1 and #2 fix the actual crash. Patches #3 and #4 optimize the
> EFI persistent memreserve infrastructure so that fewer memblock reservations
> are required.

I acked the arm64 part and patches 3 and 4 look good afaict, so:

Acked-by: Will Deacon <will.deacon@arm.com>

for those as well.

The only thing I was wondering is whether or not exhausting the page-sized
array in the first list entry is rare enough that we could just realloc the
thing and copy instead of chaining together new pages. That said, without
seeing the code it's hard to tell whether you save much complexity with such
a scheme so I'll leave it up to you.

Will
