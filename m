From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 27 Jul 2015 13:14:55 +0100
Subject: [PATCH] arm64/efi: map the entire UEFI vendor string before
 reading it
In-Reply-To: <1437915540-7553-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1437915540-7553-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150727121455.GF29945@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 26, 2015 at 02:59:00PM +0200, Ard Biesheuvel wrote:
> At boot, the UTF-16 UEFI vendor string is copied from the system
> table into a char array with a size of 100 bytes. However, this
> size of 100 bytes is also used for memremapping() the source,
> which may not be sufficient if the vendor string exceeds 50
> UTF-16 characters, and the placement of the vendor string inside
> a 4 KB page happens to leave the end unmapped.
> 
> So use the correct '100 * sizeof(efi_char16_t)' for the size of
> the mapping.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Hello Catalin,
> 
> I think this should go into v4.2 with a cc: stable.

If it's cc stable, do you have a Fixes: tag? (it saves me some
searching).

-- 
Catalin
