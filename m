From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 18 Feb 2016 15:15:44 -0600
Subject: [PATCH v3 0/5] ACPI: parse the SPCR table
In-Reply-To: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <56C63480.5020605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2016 12:05 PM, Aleksey Makarov wrote:
> This patchset is based on the patchset by Leif Lindholm [1]
>
> 'ARM Server Base Boot Requirements' [2] mentions SPCR (Serial Port
> Console Redirection Table) [3] as a mandatory ACPI table that
> specifies the configuration of serial console.
>
> SPCR support is included in QEMU's ARM mach-virt since 2.4 release.
>
> Introduce a new function acpi_console_check().  At the uart port
> registration, this function checks if the ACPI SPCR table specifies
> its argument of type struct uart_port to be a console
> and if so calls add_preferred_console().
>
> Use SPCR to tell if SBSA serial driver should use 32-bit access to registers.
>
> To be able to access SPCR table each time any console is registered
> change __init to __ref for early_acpi_os_unmap_memory().
>
> The patchset should be applied to tty-next.
(trimming)

This works on the JunoR2 with a new enough firmware to have the SPCR table.

Tested-by: Jeremy Linton <jeremy.linton@arm.com>
