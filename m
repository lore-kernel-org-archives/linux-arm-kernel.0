From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 16:13:11 +0100
Subject: [PATCH V5] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <1416977469-20232-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1416977469-20232-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <201411281613.11626.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> Initial revision of device tree for AMD Seattle Development platform.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Signed-off-by: Joel Schopp <Joel.Schopp@amd.com>
> ---
> V5 Changes:
>   * Rebase to arm-soc for-next (per Olof)
>   * Restructure the DTS/DTSI into board and SoC configurations (per Olof)
>   * Add model property at the top level (per Olof)
>   * Move pcie0 under smb and change smb's ranges property to empty since pcie
>     is not in the same range. (per Olof)
>   * Change v2m0's ranges property (per Arnd)
>   * Change timer interrupt type to level-trigger (per Marc)

Applied to next/arm64, thanks!

Looking at this one more time, I had another question:

> +	smb0: smb {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* DDR range is 40-bit addressing */
> +		dma-ranges = <0x80 0x0 0x80 0x0 0x7f 0xffffffff>;
> +

What is a DDR range?

Also, what is special about the last byte? Did you intentionally
leave it out? I think when we calculate the dma mask, we will
use 0x3fffffffff so we don't step on the last byte, which I assume
is not what you intended.

	Arnd
