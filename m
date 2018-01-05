From: sean@mess.org (Sean Young)
Date: Fri, 5 Jan 2018 12:02:53 +0000
Subject: [PATCH v3 0/6] arm: sunxi: IR support for A83T
In-Reply-To: <20171219080747.4507-1-embed3d@gmail.com>
References: <20171219080747.4507-1-embed3d@gmail.com>
Message-ID: <20180105120253.zvwaz25scuk76bnt@gofer.mess.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 09:07:41AM +0100, Philipp Rossak wrote:
> This patch series adds support for the sunxi A83T ir module and enhances 
> the sunxi-ir driver. Right now the base clock frequency for the ir driver
> is a hard coded define and is set to 8 MHz.
> This works for the most common ir receivers. On the Sinovoip Bananapi M3 
> the ir receiver needs, a 3 MHz base clock frequency to work without
> problems with this driver.
> 
> This patch series adds support for an optinal property that makes it able
> to override the default base clock frequency and enables the ir interface 
> on the a83t and the Bananapi M3.
> 
> changes since v2:
> * reorder cir pin (alphabetical)
> * fix typo in documentation
> 
> changes since v1:
> * fix typos, reword Documentation
> * initialize 'b_clk_freq' to 'SUNXI_IR_BASE_CLK' & remove if statement
> * change dev_info() to dev_dbg()
> * change naming to cir* in dts/dtsi
> * Added acked Ackedi-by to related patch
> * use whole memory block instead of registers needed + fix for h3/h5
> 
> changes since rfc:
> * The property is now optinal. If the property is not available in 
>   the dtb the driver uses the default base clock frequency.
> * the driver prints out the the selected base clock frequency.
> * changed devicetree property from base-clk-frequency to clock-frequency
> 
> Regards,
> Philipp
> 
> 
> Philipp Rossak (6):
>   media: rc: update sunxi-ir driver to get base clock frequency from
>     devicetree
>   media: dt: bindings: Update binding documentation for sunxi IR
>     controller
>   arm: dts: sun8i: a83t: Add the cir pin for the A83T
>   arm: dts: sun8i: a83t: Add support for the cir interface
>   arm: dts: sun8i: a83t: bananapi-m3: Enable IR controller
>   arm: dts: sun8i: h3-h8: ir register size should be the whole memory
>     block

I can take this series (through rc-core, i.e. linux-media), but I need an
maintainer Acked-by: for the sun[x8]i dts changes (all four patches).

>  Documentation/devicetree/bindings/media/sunxi-ir.txt |  3 +++
>  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts         |  7 +++++++
>  arch/arm/boot/dts/sun8i-a83t.dtsi                    | 15 +++++++++++++++
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi                   |  2 +-
>  drivers/media/rc/sunxi-cir.c                         | 19 +++++++++++--------
>  5 files changed, 37 insertions(+), 9 deletions(-)


Thanks
Sean
