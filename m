From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 23:25:44 +0200
Subject: [PATCH defconfig v8] ARM: vf610m4: add defconfig for Linux on
 Vybrids Cortex-M4
In-Reply-To: <1432073182-27114-1-git-send-email-stefan@agner.ch>
References: <1432073182-27114-1-git-send-email-stefan@agner.ch>
Message-ID: <7545746.Jl1zbQvhrm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 00:06:22 Stefan Agner wrote:
> Add defconfig for Linux on Vybrid (vf610) on the secondary Cortex-
> M4 CPU. The use of a XIP image has been tested which needs to be
> loaded (e.g. using the custom m4boot loader) to the end of the
> available RAM at address 0x8f000000. The Cortex-M4 has a code-alias
> which makes sure that the instructions get fetched through the code
> bus (alias starts at 0x00800000 => 0x80800000 in system address).
> Hence, to get optimal performance, use 0x0f000000 as XIP_PHYS_ADDR.
> This address is additionally shifted by the length of the minimal
> loader which is inserted by m4boot. Currently, this offset is 0x80.
> 
> The standard DRAM base address is configured to 0x8C000000, which
> gives the Cortex-M4 48MiB of RAM.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 

Applied to next/defconfig, thanks!

	Arnd
