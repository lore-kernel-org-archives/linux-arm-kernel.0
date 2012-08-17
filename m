From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 01:56:15 -0700
Subject: [PATCH v2 02/31] arm64: Kernel booting and initialisation
In-Reply-To: <1344966752-16102-3-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120817085615.GO11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [120814 11:00]:
> +3. Decompress the kernel image
> +------------------------------
> +
> +Requirement: OPTIONAL
> +
> +The AArch64 kernel does not provide a decompressor and therefore
> +requires gzip decompression to be performed by the boot loader if the
> +default Image.gz target is used.  For bootloaders that do not implement
> +this requirement, the larger Image target is available instead.

Maybe add something here about why AArch64 does not provide a
decompressor? That's something everybody will wonder while reading
this part.

> +- Caches, MMUs
> +  The MMU must be off.
> +  Instruction cache may be on or off.
> +  Data cache must be off and invalidated.

External caches must be configured by bootloader but set to disabled
state?

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
