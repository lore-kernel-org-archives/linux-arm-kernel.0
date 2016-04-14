From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 14 Apr 2016 18:26:44 +0100
Subject: [PATCH] arm64: acpi: add acpi=on cmdline option to prefer ACPI
 boot over DT
In-Reply-To: <1460470151-19479-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1460470151-19479-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160414172643.GG15182@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 04:09:11PM +0200, Ard Biesheuvel wrote:
> If both ACPI and DT platform descriptions are available, and the
> kernel was configured at build time to support both flavours, the
> default policy is to prefer DT over ACPI, and preferring ACPI over
> DT while still allowing DT as a fallback is not possible.
> 
> Since some enterprise features (such as RAS) depend on ACPI, it may
> be desirable for, e.g., distro installers to prefer ACPI boot but
> fall back to DT rather than failing completely if no ACPI tables are
> available.
> 
> So introduce the 'acpi=on' kernel command line parameter for arm64,
> which signifies that ACPI should be used if available, and DT should
> only be used as a fallback.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
