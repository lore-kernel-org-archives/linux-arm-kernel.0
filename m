From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 17:16:11 +0200
Subject: [PATCH RESEND] arm64: dts: kill skeleton.dtsi
In-Reply-To: <1431011699-15455-1-git-send-email-mark.rutland@arm.com>
References: <1431011699-15455-1-git-send-email-mark.rutland@arm.com>
Message-ID: <3292743.JoE0ExITrf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 May 2015 16:14:59 Mark Rutland wrote:
> While skeleton.dtsi was initially conceived as a simple way to bootstrap
> writing a dts, it has proven to be problematic:
> 
> * The #address-cells and #size-cells values used in skeleton.dtsi may
>   not match what a user wants (e.g. when they need to describe a range
>   larger than 4GB).
> 
> * For dts files where memory nodes have unit-addresses, it adds a
>   redundant /memory node, for which the reg entry may not be
>   appropriately sized (e.g. where #size-cells has been overridden).
> 
> * For dts files which assume that a bootloader will fill in the memory
>   node(s), no node is present in the dts (and hence there is no attached
>   comment), making it hard to distinguish these cases from bad dts
>   files, and masking any warnings dtc may produce w.r.t. missing nodes.
> 
> * The default empty /chosen and /aliases are somewhat useless, and it
>   would be preferable for dts to fill these in (e.g. for
>   /aliases/serial0 and /chosen/stdout-path).
> 
> This patch removes skeleton.dtsi from arm64. There are currently no
> users, so we can remove it before any appear.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Rob Herring <rob.herring@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/boot/dts/skeleton.dtsi | 13 -------------
>  1 file changed, 13 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/skeleton.dtsi
> 
> Arnd, Olof, are you happy to pick this up for v4.2?
> 
> 

Applied to next/cleanup now, thanks!

	Arnd
