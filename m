From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 16 Feb 2016 21:36:10 -0500
Subject: [PATCH v3 0/5] ACPI: parse the SPCR table
In-Reply-To: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <FD7CEA09-FFB5-4707-A4AE-7F721491C327@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On February 15, 2016 1:05:24 PM EST, Aleksey Makarov <aleksey.makarov@linaro.org> wrote:
>This patchset is based on the patchset by Leif Lindholm [1]
>
>'ARM Server Base Boot Requirements' [2] mentions SPCR (Serial Port
>Console Redirection Table) [3] as a mandatory ACPI table that
>specifies the configuration of serial console.
>
>SPCR support is included in QEMU's ARM mach-virt since 2.4 release.
>
>Introduce a new function acpi_console_check().  At the uart port
>registration, this function checks if the ACPI SPCR table specifies
>its argument of type struct uart_port to be a console
>and if so calls add_preferred_console().
>
>Use SPCR to tell if SBSA serial driver should use 32-bit access to
>registers.

On QDF2432:

Tested-by: Christopher Covington <cov@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

Sent from my Snapdragon powered Android device with K-9 Mail. Please excuse my brevity.
