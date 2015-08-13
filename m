From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 13 Aug 2015 16:16:40 +0200
Subject: [PATCH] [ARM][TEGRA] Fix AHB base address on tegra20, tegra30
 and tegra114
In-Reply-To: <1439042292-19912-1-git-send-email-kwizart@gmail.com>
References: <1439042292-19912-1-git-send-email-kwizart@gmail.com>
Message-ID: <20150813141639.GA26559@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 03:58:12PM +0200, Nicolas Chauvet wrote:
> Current base address is wrong by 0x04 bytes for AHB bus device as shown in dmesg:
>  tegra-ahb 6000c004.ahb: incorrect AHB base address in DT data - enabling workaround
> 
> To correct old dtbs,  the commit ce7a10b0ff3db63 checks for the low bit
> of the base address and removes theses 0x04 bytes at runtime.
> 
> This patch fix the original dts, so upstream version doesn't need
> the workaround of the base address.
> 
> As both addresses are valid, this patch doesn't break compatibility
> 
> Tested on tegra20-paz00 (aka ac100)
> 
> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
> ---
>  arch/arm/boot/dts/tegra114.dtsi | 4 ++--
>  arch/arm/boot/dts/tegra20.dtsi  | 4 ++--
>  arch/arm/boot/dts/tegra30.dtsi  | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/f2090462/attachment.sig>
