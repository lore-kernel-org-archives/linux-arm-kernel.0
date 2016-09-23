From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 08:35:29 -0500
Subject: [PATCH 2/3] nvmem: dt: document lpc1850 OTP binding
In-Reply-To: <20160913161241.22492-3-manabian@gmail.com>
References: <20160913161241.22492-1-manabian@gmail.com>
 <20160913161241.22492-3-manabian@gmail.com>
Message-ID: <20160923133529.GA23548@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 06:12:40PM +0200, Joachim Eastwood wrote:
> Documenation for the LPC18xx/43xx OTP memory bindings.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  .../devicetree/bindings/nvmem/lpc1850-otp.txt        | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/lpc1850-otp.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/lpc1850-otp.txt b/Documentation/devicetree/bindings/nvmem/lpc1850-otp.txt
> new file mode 100644
> index 0000000..853b6a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/lpc1850-otp.txt
> @@ -0,0 +1,20 @@
> +* NXP LPC18xx OTP memory
> +
> +Internal OTP (One Time Programmable) memory for NXP LPC18xx/43xx devices.
> +
> +Required properties:
> +  - compatible: Should be "nxp,lpc1850-otp"
> +  - reg: Must contain an entry with the physical base address and length
> +    for each entry in reg-names.

> +  - address-cells: must be set to 1.
> +  - size-cells: must be set to 1.

Not needed unless you have child nodes.

> +
> +See nvmem.txt for more information.
> +
> +Example:
> +  otp: otp at 40045000 {
> +    compatible = "nxp,lpc1850-otp";
> +    reg = <0x40045000 0x1000>;
> +    #address-cells = <1>;
> +    #size-cells = <1>;
> +  };
> -- 
> 2.9.3
> 
