From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 29 Apr 2014 12:27:20 +0100
Subject: [PATCH v2 08/10] arm64: efi: add EFI stub
In-Reply-To: <1398442154-19974-9-git-send-email-leif.lindholm@linaro.org>
References: <1398442154-19974-1-git-send-email-leif.lindholm@linaro.org>
 <1398442154-19974-9-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140429112720.GI26088@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Apr, at 05:09:12PM, Leif Lindholm wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> This patch adds PE/COFF header fields to the start of the kernel
> Image so that it appears as an EFI application to UEFI firmware.
> An EFI stub is included to allow direct booting of the kernel
> Image.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> [Add support in PE/COFF header for signed images]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  arch/arm64/Kconfig              |    5 +-
>  arch/arm64/kernel/Makefile      |    4 +-
>  arch/arm64/kernel/efi-entry.S   |  109 +++++++++++++++++
>  arch/arm64/kernel/efi-stub.c    |   81 +++++++++++++
>  arch/arm64/kernel/head.S        |  112 ++++++++++++++++++
>  drivers/firmware/efi/arm-stub.c |  247 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 555 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/kernel/efi-entry.S
>  create mode 100644 arch/arm64/kernel/efi-stub.c
>  create mode 100644 drivers/firmware/efi/arm-stub.c

For the drivers/firmware/efi/arm-stub.c bits,

Acked-by: Matt Fleming <matt.fleming@intel.com>

-- 
Matt Fleming, Intel Open Source Technology Center
