From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 13:47:45 -0600
Subject: [PATCHv2 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager
 binding
In-Reply-To: <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com>
Message-ID: <20180307194745.657ewa6rtcta6eqm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 06:19:32PM -0600, richard.gong at linux.intel.com wrote:
> From: Alan Tull <atull@kernel.org>
> 
> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: this patch is added in patch set version 2
> ---
>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> new file mode 100644
> index 0000000..78de689
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> @@ -0,0 +1,10 @@
> +Intel Stratix10 SoC FPGA Manager
> +
> +Required properties:
> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
> +
> +Example:
> +
> +	fpga_mgr: fpga-mgr at 0 {
> +		compatible = "intel,stratix10-soc-fpga-mgr";

No reg or anything else? Is that because it all goes thru the service 
layer firmware? Just get the service layer driver to instantiate a 
device for this driver or get rid of the 2 layers if that's all the 
firmware interface does. DT is not a Linux driver instantiation 
mechanism.

And build your dts files with "W=1" because there's an error in this 
example.

Rob
