From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 16:24:35 -0500
Subject: [patch v3 3/3] doccumentation: jtag: Add bindings for Aspeed SoC
 24xx and 25xx families JTAG master driver
In-Reply-To: <1502791207-26951-4-git-send-email-oleksandrs@mellanox.com>
References: <1502791207-26951-1-git-send-email-oleksandrs@mellanox.com>
 <1502791207-26951-4-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20170817212435.ypzsc3e6x2m4owyc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 01:00:07PM +0300, Oleksandr Shamray wrote:
> It has been tested on Mellanox system with BMC equipped with
> Aspeed 2520 SoC for programming CPLD devices.
> 
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> ---
> v2->v3
> Comments pointed by Rob Herring <robh@kernel.org>
> - split Aspeed jtag driver and binding to sepatrate patches
> - delete unnecessary "status" and "reg-shift" descriptions in
>   bndings file
> ---
>  .../devicetree/bindings/jtag/aspeed-jtag.txt       |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
> 
> diff --git a/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt b/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
> new file mode 100644
> index 0000000..4743d6d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
> @@ -0,0 +1,19 @@
> +Aspeed JTAG driver for ast2400 and ast2500 SoC
> +
> +Required properties:
> +- compatible:		Should be one of
> +      - "aspeed,aspeed2400-jtag"
> +      - "aspeed,aspeed2500-jtag"
> +- reg			contains the offset and length of the JTAG memory
> +			region
> +- clocks		root clock of bus, should reference the APB clock
> +- interrupts		should contain JTAG controller interrupt
> +
> +Example:
> +jtag: jtag at 1e6e4000 {
> +	compatible = "aspeed,aspeed2500-jtag";
> +	reg = <0x1e6e4000 0x1c>;
> +	reg-shift = <2>;

Still here...

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> +	clocks = <&clk_apb>;
> +	interrupts = <43>;
> +};
> -- 
> 1.7.1
> 
