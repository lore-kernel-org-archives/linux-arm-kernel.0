From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Feb 2014 16:40:19 +0000
Subject: [PATCH 1/4] phy: miphy365x: Add Device Tree bindings for the
 MiPHY365x
In-Reply-To: <1392220985-28189-1-git-send-email-lee.jones@linaro.org>
References: <1392220985-28189-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140212164019.GE25957@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 04:03:02PM +0000, Lee Jones wrote:
> The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> devices. It has 2 ports which it can use for either; both SATA, both
> PCIe or one of each in any configuration.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/phy/phy-miphy365x.txt      | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-miphy365x.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-miphy365x.txt b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
> new file mode 100644
> index 0000000..fdfa7ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
> @@ -0,0 +1,43 @@
> +STMicroelectronics STi MIPHY365x PHY binding
> +============================================
> +
> +This binding describes a miphy device that is used to control PHY hardware
> +for SATA and PCIe.
> +
> +Required properties:
> +- compatible: Should be "st,miphy365x-phy"
> +- #phy-cells: Should be 2 (See example)

The first example has #phy-cells = <1>.

What do the cells mean? What are the expected values?

> +- reg:	      Address and length of the register set for the device
> +- reg-names:  The names of the register addresses corresponding to the
> +	      registers filled in "reg".

Whenever there is a ${PROP}-names property, there should be a list of
explicit values, and a description of how it relates to ${PROP}. Without
that it's a bit useless.

Please provide an explicit list of expected names here.

I assume here what you want is something like:

- reg: a list of address + length pairs, one for each entry in reg-names
- reg-names: should contain:
  * "sata0" for the sata0 control registers...
  * "sata1" ...
  * "pcie0" ...
  * "pcie1" ...

> +- st,syscfg : Should be a phandle of the syscfg node.

What's this used for?

Cheers,
Mark.
