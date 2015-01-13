From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 14 Jan 2015 00:02:27 +0100
Subject: [PATCH 1/4] rtc: armada38x: Add the device tree binding
 documentation
References: <1420817565-28800-1-git-send-email-gregory.clement@free-electrons.com>
 <1420817565-28800-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <87iogai8sc.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> The Armada 38x SoCs come with a new RTC which differs from the one
> used in the other mvebu SoCs until now. This patch describes the
> binding of this RTC.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/armada-380-rtc.txt          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
>
> diff --git a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
> new file mode 100644
> index 000000000000..2c56bef9dd7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
> @@ -0,0 +1,17 @@
> +* Real Time Clock of te Armada 38x SoCs
> +
> +RTC controller for the Armada 38x SoCs
> +
> +Required properties:
> +- compatible : Should be "marvell,armada-380-rtc"
> +- reg: physical base address of the controller and length of memory mapped
> +  region. The second entires is for the IP configuration part.
                        ^^^^^^^
                        entry

I had to read probe function to understand precisely the purpose of each
region, i.e. IMHO the description could be made a bit clearer.

> +- interrupts: IRQ line for the RTC.
>
> +
> +Example:
> +
> +rtc at 184a8 {
> +	compatible = "marvell,armada-380-rtc";
> +	reg = <0xa3800 0x20>, <0x184a0 0x0c>;
> +	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +};
