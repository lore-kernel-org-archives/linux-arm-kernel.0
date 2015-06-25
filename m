From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 25 Jun 2015 16:18:00 +0100
Subject: [PATCH] i2c: removed work arounds in i2c driver for Zynq
 Ultrascale+ MPSoC
In-Reply-To: <1434644382-11905-1-git-send-email-anuragku@xilinx.com>
References: <1434644382-11905-1-git-send-email-anuragku@xilinx.com>
Message-ID: <20150625151800.GC6844@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 05:19:42PM +0100, Anurag Kumar Vulisha wrote:
> Removed the workarounds present in the cadence i2c driver for
> Zynq Ultrascale+ MPSoC

I guess this means that cdns,i2c-r1p10 had quirks fixed in
cdns,i2c-r1p14? It would be helpful to be a bit more explicit in the
commit message.

> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> ---
>  .../devicetree/bindings/i2c/i2c-cadence.txt        |    2 +-
>  drivers/i2c/busses/i2c-cadence.c                   |   67 ++++++++++++++++---
>  2 files changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> index 7cb0b56..11ef7f2 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> @@ -2,7 +2,7 @@ Binding for the Cadence I2C controller
>  
>  Required properties:
>    - reg: Physical base address and size of the controller's register area.
> -  - compatible: Compatibility string. Must be 'cdns,i2c-r1p10'.
> +  - compatible: Compatibility string.Use 'cdns,i2c-r1p10' or 'cdns,i2c-r1p14'

Please format this as a list. It aids legibility and expansion. e.g:

- compatible: should contain one of:
  * "cdns,i2c-r1p10"
  * "cdns,i2c-r1p14"

Perhaps with notes as to the differences.

Thanks,
Mark.
