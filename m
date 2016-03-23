From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Mar 2016 22:36:30 +0530
Subject: [PATCH v2 05/11] dt-bindings: Add bindings for phy-da8xx-usb
In-Reply-To: <1458181615-27782-6-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-6-git-send-email-david@lechnology.com>
Message-ID: <56F2CD16.9060106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 March 2016 07:56 AM, David Lechner wrote:
> Device tree binding for new phy-da8xx-usb driver.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes: This is new patch in v2.
> 
> 
>  .../devicetree/bindings/phy/phy-da8xx-usb.txt      | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt
> new file mode 100644
> index 0000000..ed6b710
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt
> @@ -0,0 +1,34 @@
> +TI DaVinci DA8XX USB PHY
> +
> +Required properties:
> + - compatible: must be "ti,da830-usbphy".
> + - #phy-cells: must be 1.
> + - reg : Address and length of the CFGCHIP2 register.

I am not sure passing CFGCHIP2 register as reg property to the phy is
future proof. At some point, we do want to move to common clock
framework and at that point USB clocks controlled by CFGCHIP2 will be a
separate driver needing access to the same register.

So I think the CFGCHIP2 access in USB phy driver should happen through a
syscon phandle. This needs to happen now, not later since we cannot
break DT backward-compatibility.

Thanks,
Sekhar
