From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Mon, 12 Jan 2015 10:43:39 +0000
Subject: [PATCH v4 6/8] arm64/efi: move SetVirtualAddressMap() to UEFI stub
In-Reply-To: <20150106180120.GF3827@bivouac.eciton.net>
References: <1419245944-2424-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419245944-2424-7-git-send-email-ard.biesheuvel@linaro.org>
 <20150105165402.GE3163@console-pimps.org>
 <20150106180120.GF3827@bivouac.eciton.net>
Message-ID: <20150112104339.GB26589@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Jan, at 06:01:20PM, Leif Lindholm wrote:
> On Mon, Jan 05, 2015 at 04:54:02PM +0000, Matt Fleming wrote:
> 
> I think all we really need above what efi_get_memory_map() provides is
> the scratch space. Would we care about temporarily wasting a little
> bit of EFI_LOADER_DATA on all platforms, or could we just swap the
> function body in efi-stub-helper.c for Ard's version above?
> 
> (I would guess memory maps with <= 32 entries are uncommon anyway, so
> the existing version would already make the bootservice call twice.)
 
I've no concerns about using the additional scratch space.

[...]

> Mmm, not optimal.
> That said, the only arm*-specific things about this particular
> function are the page sizes. Should this move to efi-stub-helper.c
> with EFI_RT_VIRTUAL_BASE moved to arch/<x>/include/asm/efi.h and
> joined by EFI_RT_VIRTUAL_BASE_ALIGN and EFI_RT_VIRTUAL_REGION_ALIGN?

Yeah, that would be an improvement. It's possible we could reuse some of
this code for x86's EFI virtual mapping code that Borislav wrote
(maybe).

-- 
Matt Fleming, Intel Open Source Technology Center
