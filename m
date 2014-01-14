From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jan 2014 22:26:21 +0100
Subject: [PATCH] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to
 enforce this ACPI mode
In-Reply-To: <1389731822-21336-1-git-send-email-al.stone@linaro.org>
References: <1389731822-21336-1-git-send-email-al.stone@linaro.org>
Message-ID: <15081767.3kxW799CSQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 January 2014 13:37:02 al.stone at linaro.org wrote:
> +config ACPI_REDUCED_HARDWARE_ONLY
> +       bool "Hardware-reduced ACPI support only"
> +       def_bool n
> +       depends on ACPI && EXPERT

I think this will cause a Kconfig warning if you try to select this
on ARM64 without turning on EXPERT as well. 

It should be ok if you express it as

config ACPI_REDUCED_HARDWARE_ONLY
       bool "Hardware-reduced ACPI support only" if EXPERT
       def_bool n
       depends on ACPI


	Arnd
