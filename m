From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Dec 2013 04:48:09 +0100
Subject: [RFC part2 PATCH 8/9] ACPI / ARM64: Update acpi_register_gsi to
 register with the core IRQ subsystem
In-Reply-To: <1386088753-2850-9-git-send-email-hanjun.guo@linaro.org>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
 <1386088753-2850-9-git-send-email-hanjun.guo@linaro.org>
Message-ID: <201312050448.10312.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 December 2013, Hanjun Guo wrote:
> +       /*
> +        * ACPI have no bindings to indicate SPI or PPI, so we
> +        * use different mappings from DT in ACPI.
> +        *
> +        * For FDT
> +        * PPI interrupt: in the range [0, 15];
> +        * SPI interrupt: in the range [0, 987];
> +        *
> +        * For ACPI, using identity mapping for hwirq:
> +        * PPI interrupt: in the range [16, 31];
> +        * SPI interrupt: in the range [32, 1019];

This difference might cause endless confusion. Can't you register PPI and SPI as
separate IRQ controllers to have the same number space that we normally have?

	Arnd
