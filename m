From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Apr 2016 14:07:51 +0100
Subject: [PATCH] arm64: acpi: add a Kconfig option to prefer ACPI boot
 over DT
In-Reply-To: <1460373568-4374-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1460373568-4374-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160412130751.GA8066@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 01:19:28PM +0200, Ard Biesheuvel wrote:
> If both ACPI and DT platform descriptions are available, and the
> kernel was configured at build time to support both flavours, the
> default policy in absence of a acpi=[off|force] kernel command line
> parameter is to prefer DT over ACPI.
> 
> This adds an option to invert that default policy, and prefer ACPI
> over DT instead. Note that this policy is still superseded by the
> value of the acpi= command line parameter.

Why do we need another method to specify an ACPI boot? I thought those
vendors going for ACPI wouldn't be bothered with DT anyway.

I'm not keen on having kernel builds with different behavior in respect
of whether ACPI or DT is preferred.

-- 
Catalin
