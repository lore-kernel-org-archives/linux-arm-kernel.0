From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 12 Aug 2013 13:18:45 +0200
Subject: [PATCH V4 0/4]  Add i2s nodes on Exynos5420 and enable sound
 support on sdmk5420
In-Reply-To: <1376302070-1877-1-git-send-email-padma.v@samsung.com>
References: <1376302070-1877-1-git-send-email-padma.v@samsung.com>
Message-ID: <1563060.2xzTKrBOxD@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Padmavathi,

On Monday 12 of August 2013 15:37:46 Padmavathi Venna wrote:
> Changes since V3:
> 	- used existent fixed-clock binding for registering oscillator clock
> 	  as fixed rate clock as pointed by Tomasz Figa
> 	- Made some changes in wm8994 regulator nodes as suggested by Tomasz
> Figa - Separated out only adding i2s nodes and enabling sound support on
> smdk5420 into different patch set as they are dependent on on some of
> already posted but not yet merged i2c, dwmmc, dma and audss clock
> controller patches on Kukjin for-next branch.
> 
> Changes since V2:
>         - Separated out driver side changes and dts changes in two
>           patch sets
>         - Added proper names for wm8994 regulators as commented by Mark
>         - Moved common i2s nodes into the exynos5.dtsi
>         - Added clock info in wm8994 node as requested by Mark.
>         - Registered the 16.9MHz oscillator clock as fixed clock in the
>           machine file. Right now no user of this clock but as Mark
> requested to add mclk info in wm8994 node, I added this part.
> 
> This patch set is dependent on the following i2c, dma and audio subsystem
> clk controller patches.
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/20077
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/20661
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/20668
> 
> This patch set is made based on Kukjin Kim for-next branch.
> 
> 
> Andrew Bresticker (1):
>   ARM: dts: exynos5420: add i2s controllers
> 
> Padmavathi Venna (3):
>   ARM: dts: Add i2c bus 1 and it's audio codec child node on smdk5420
>   ARM: dts: Add osc clock node on smdk5420.
>   ARM: dts: Enable sound support on smdk5420
> 
>  arch/arm/boot/dts/exynos5420-smdk5420.dts |   81
> +++++++++++++++++++++++++++++ arch/arm/boot/dts/exynos5420.dtsi        
> |   32 +++++++++++
>  2 files changed, 113 insertions(+), 0 deletions(-)

Except the node status misuse that I commented on in patches 1/4 and 4/4, 
looks good to me:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
