From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 5 May 2014 16:16:52 -0700
Subject: [PATCHv3 1/3] dts: socfpga: Add bindings for Altera SoC SDRAM
 controller
In-Reply-To: <1399330337-16748-2-git-send-email-tthayer@altera.com>
References: <1399330337-16748-1-git-send-email-tthayer@altera.com>
 <1399330337-16748-2-git-send-email-tthayer@altera.com>
Message-ID: <ba35254f-4ba5-4b2c-8056-cde5c693b0ff@CH1EHSMHS009.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thor,

On Mon, 2014-05-05 at 05:52PM -0500, tthayer at altera.com wrote:
> From: Thor Thayer <tthayer@altera.com>
> 
> Addition of the Altera SDRAM controller bindings and device
> tree changes to the Altera SoC project. The "syscon" parameter
> is included here because the SDRAM EDAC bits are shared with the SDRAM
> configuration bits.
> ---
> v2: Changes to SoC SDRAM EDAC code.
> 
> V3: Implement code suggestions for SDRAM EDAC code.
> 
> Signed-off-by: Thor Thayer <tthayer@altera.com>
> ---
>  .../bindings/arm/altera/socfpga-sdram.txt          |   14 ++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |    5 +++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
> new file mode 100644
> index 0000000..525cb76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
> @@ -0,0 +1,14 @@
> +Altera SOCFPGA SDRAM Controller
> +
> +Required properties:
> +- compatible : "altr,sdr-ctl", "syscon";
> +                Note that syscon is invoked for this device to support the FPGA
> +		bridge driver, EDAC driver and other devices that share the
> +		registers.

This sounds like implementation specifics, which shouldn't be part of
the bindings.

	S?ren
