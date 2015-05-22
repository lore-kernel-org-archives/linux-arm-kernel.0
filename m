From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 10:02:31 +0200
Subject: [PATCH v10 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <1431991481-25684-4-git-send-email-lho@apm.com>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <1431991481-25684-3-git-send-email-lho@apm.com>
 <1431991481-25684-4-git-send-email-lho@apm.com>
Message-ID: <2511694.W7d3YRYFRf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 May 2015 17:24:39 Loc Ho wrote:
> This patch adds documentation for the APM X-Gene SoC EDAC DTS binding.
> 
> Signed-off-by: Loc Ho <lho@apm.com>

This is starting to look pretty good. One final comment:

> +Example:
> +	csw: csw at 7e200000 {
> +		compatible = "syscon";
> +		reg = <0x0 0x7e200000 0x0 0x1000>;
> +	};
> +
> +	mcba: mcba at 7e700000 {
> +		compatible = "syscon";
> +		reg = <0x0 0x7e700000 0x0 0x1000>;
> +	};
> +
> +	mcbb: mcbb at 7e720000 {
> +		compatible = "syscon";
> +		reg = <0x0 0x7e720000 0x0 0x1000>;
> +	};
> +
> +	efuse: efuse at 1054a000 {
> +		compatible = "syscon";
> +		reg = <0x0 0x1054a000 0x0 0x20>;
> +	};

I think it would be helpful to assign a proper compatible string (in
addition o syscon, not replacing it) for each of these, just in case
we ever need to add a proper driver for one of them, or in case a
future chip uses an unmodified edac block with a slightly different
set of fuses or other registers that are referenced here.

	Arnd
