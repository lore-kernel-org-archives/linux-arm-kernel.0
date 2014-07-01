From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 1 Jul 2014 10:22:01 +0100
Subject: [PATCH v4 13/13] ARM64 / ACPI: Enable ARM64 in Kconfig
In-Reply-To: <53B26F44.7050404@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
 <1403840976-7456-14-git-send-email-hanjun.guo@linaro.org>
 <20140630104652.GG28951@arm.com> <53B2694F.7070501@linaro.org>
 <53B26F44.7050404@linaro.org>
Message-ID: <20140701092201.GF18313@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 09:20:20AM +0100, Hanjun Guo wrote:
> >>>  	depends on PCI
> >>>  	select PNP
> >>> -	default y
> >>> +	default y if !ARM64
> >>
> >> For the benefit of single Image, I think you can default to y here.
> > 
> > It ok to me. if we default to y here, devicetree will not be unflattened
> > in default, is it ok to you? you can refer to "[PATCH 12/13] ARM64 / ACPI: if
> > we chose to boot from acpi then disable FDT".
> 
> Ah, sorry I didn't describe it clearly. since there is no shipping board
> with ACPI tables, so ACPI will disabled in the very early stage and FDT
> still have chance to be unflattened, so will not break DT booting in
> this patchset.

That's what I thought. So leaving it as a default y is fine by me. But I
would not merge this patch now until we get some useful functionality
for arm64.

The x86-related cleanup patches can be merged separately via the
corresponding trees (it's up to the ACPI and x86 maintainers).

-- 
Catalin
