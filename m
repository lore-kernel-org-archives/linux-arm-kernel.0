From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 21 Mar 2016 15:32:17 -0500
Subject: [PATCH 2/2] ARM: socfpga: dts: Drop gmac0 from CV dtsi
In-Reply-To: <1458431825-9159-2-git-send-email-marex@denx.de>
References: <1458431825-9159-1-git-send-email-marex@denx.de>
 <1458431825-9159-2-git-send-email-marex@denx.de>
Message-ID: <56F05A51.9000203@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2016 06:57 PM, Marek Vasut wrote:
> The socfpga_cyclone5.dtsi is included by all DTS files which describe boards
> using the Cyclone V SoC. The Cyclone V SoC has two ethernet controllers and
> different boards use none, one or both of them.
> 
> The /soc/ethernet at ff702000/{} node in socfpga_cyclone5.dtsi unconditionaly
> enabled gmac0 interface, which is clearly wrong for those boards which use
> gmac1 interface instead.
> 
> This patch removes the entire /soc/ethernet at ff702000/{} node from the
> socfpga_cyclone5.dtsi file. This is correct, since all of the board which
> include this file also have correct gmac0 or gmac1 node present in them.
> Minor correction had to be done to EBV SoCrates, which didn't define PHY
> mode explicitly, but inherited it from the socfpga_cyclone5.dtsi .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi         | 5 -----
>  arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 1 +
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 

Both patches applied!

Thanks,
Dinh
