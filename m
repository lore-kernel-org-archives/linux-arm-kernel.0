From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Apr 2014 19:38:55 +0100
Subject: [Qemu-devel] Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <15350123.PBHzyiOlX4@wuerfel>
References: <534D0D91.8020406@linaro.org>
 <20140422171141.GW24070@n2100.arm.linux.org.uk>
 <20140422175325.GD23955@obsidianresearch.com> <15350123.PBHzyiOlX4@wuerfel>
Message-ID: <20140422183855.GZ24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 08:32:10PM +0200, Arnd Bergmann wrote:
> @@ -1943,6 +1953,7 @@ config DEPRECATED_PARAM_STRUCT
>  # TEXT and BSS so we preserve their values in the config files.
>  config ZBOOT_ROM_TEXT
>  	hex "Compressed ROM boot loader base address"
> +	depends on BROKEN_MULTIPLATFORM
>  	default "0"
>  	help
>  	  The physical address at which the ROM-able zImage is to be
> @@ -1954,6 +1965,7 @@ config ZBOOT_ROM_TEXT
>  
>  config ZBOOT_ROM_BSS
>  	hex "Compressed ROM boot loader BSS address"
> +	depends on BROKEN_MULTIPLATFORM
>  	default "0"
>  	help
>  	  The base address of an area of read/write memory in the target

Please get rid of the above changes.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
