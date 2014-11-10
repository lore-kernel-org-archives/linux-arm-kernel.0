From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Nov 2014 17:57:32 +0100
Subject: [PATCH] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <1415638305-24463-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1415638305-24463-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <3340387.dB5eK3mRnu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 November 2014 17:51:45 Ard Biesheuvel wrote:
> Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
> that was passed to the kernel by the bootloader. This allows userland
> applications such as kexec to access the raw binary.
> 
> The fact that this node does not reside under /sys/firmware/device-tree
> is deliberate: FDT is also used on arm64 UEFI/ACPI systems to
> communicate just the UEFI and ACPI entry points, but the FDT is never
> unflattened and used to configure the system.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Can you elaborate on the motivation? Initially the fdt format was
introduced to make it easy to pass the information from /proc/device-tree
to the next kernel for kexec. Are you interested in cases where this does
not work?

	Arnd
