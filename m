From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Nov 2015 17:17:44 -0600
Subject: [PATCH v3 3/6] DT: PCI: qcom: Document PCIe devicetree bindings
In-Reply-To: <8fd3e7d1662f37abe549127d179c315dff3210d8.1448270813.git.stanimir.varbanov@linaro.org>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
 <8fd3e7d1662f37abe549127d179c315dff3210d8.1448270813.git.stanimir.varbanov@linaro.org>
Message-ID: <20151123231744.GA14078@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 11:29:00AM +0200, Stanimir Varbanov wrote:
> From: Stanimir Varbanov <svarbanov@mm-sol.com>
> 
> Document Qualcomm PCIe driver devicetree bindings.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  231 ++++++++++++++++++++
>  1 file changed, 231 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> new file mode 100644
> index 000000000000..d7640d45fa31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -0,0 +1,231 @@
> +* Qualcomm PCI express root complex
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: Value shall include
> +		    - "qcom,pcie-v0" for apq/ipq8064
> +		    - "qcom,pcie-v1" for apq8084

Use chip part numbers, not versions.

Also, shouldn't you have the Designware compatible in addition.

[...]

> +
> +- <name>-gpio:

Use -gpios

> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: List of phandle and gpio specifier pairs. Should contain
> +		    - "perst"  PCIe endpoint reset signal line
> +		    - "pewake" PCIe endpoint wake signal line
