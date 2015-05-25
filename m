From: pavel@denx.de (Pavel Machek)
Date: Mon, 25 May 2015 14:39:02 +0200
Subject: [PATCH v4 2/2] ARM: socfpga: dts: add sdram controller dt
 binding doc
In-Reply-To: <1432317735-29413-3-git-send-email-atull@opensource.altera.com>
References: <1432317735-29413-1-git-send-email-atull@opensource.altera.com>
 <1432317735-29413-3-git-send-email-atull@opensource.altera.com>
Message-ID: <20150525123902.GE9943@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2015-05-22 13:02:15, Alan Tull wrote:
> Add binding doc for Altera SOCFPGA SDRAM controller.
> 
> Signed-off-by: Alan Tull <atull@opensource.altera.com>
> ---
> v4: Add bindings doc
> ---
>  .../arm/altera/socfpga-sdram-controller.txt        |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
> new file mode 100644
> index 0000000..77ca635
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
> @@ -0,0 +1,12 @@
> +Altera SOCFPGA SDRAM Controller
> +
> +Required properties:
> +- compatible : Should contain "altr,sdr-ctl" and "syscon".
> +  syscon is required by the Altera SOCFPGA SDRAM EDAC.
> +- reg : Should contain 1 register range (address and length)
> +
> +Example:
> +	sdr: sdr at ffc25000 {
> +		compatible = "altr,sdr-ctl", "syscon";

Is the syscon binding good idea? Should the EDAC driver be fixed to
accept altr,sdr-ctl binding, instead?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
