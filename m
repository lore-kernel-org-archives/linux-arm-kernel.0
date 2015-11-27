From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 27 Nov 2015 21:25:37 +0000
Subject: [PATCH v3 00/13] UEFI boot and runtime services support for
 32-bit ARM
In-Reply-To: <1448269593-20758-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1448269593-20758-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151127212537.GD13918@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov, at 10:06:20AM, Ard Biesheuvel wrote:
> This series adds support for booting the 32-bit ARM kernel directly from
> UEFI firmware using a builtin UEFI stub. It mostly reuses refactored arm64
> code, and the differences (primarily the PE/COFF header and entry point and
> the efi_create_mapping() implementation) are split out into arm64 and ARM
> versions.

For the series,

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>

Ard, I think the next EFI area for refactoring could be the pgtable
switching code, since we've now got 3 architectures doing it. If I can
find some time in the new year I'll add a fourth (i386) and try and
pull out the common code.
