From: dianders@chromium.org (Doug Anderson)
Date: Wed, 17 Sep 2014 12:48:16 -0700
Subject: [PATCH v5 2/4] dt-bindings: document Rockchip thermal
In-Reply-To: <1410926353-15674-3-git-send-email-caesar.wang@rock-chips.com>
References: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com>
 <1410926353-15674-3-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <CAD=FV=Vq4zSBv-=OxHD4sGbAgLh_ebe29PR6RU_sQe4XspsPsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Tue, Sep 16, 2014 at 8:59 PM, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> This add the necessary binding documentation for the thermal
> found on Rockchip SoCs
>
> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> ---
>  .../bindings/thermal/rockchip-thermal.txt          | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> new file mode 100644
> index 0000000..6fc8bc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -0,0 +1,41 @@
> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
> +
> +Required properties:
> +- compatible: "rockchip,rk3288-tsadc"
> +- reg: physical base address of the controller and length of memory mapped
> +       region.
> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
> +             depends on the interrupt controller.
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Shall be "tsadc" for the converter-clock, and "apb_pclk" for
> +              the peripheral clock.
> +- num-trips:  number of total trip points, this is required, set it 0 if none,
> +             if greater than 0, the following properties must be defined;

nit: there is whitespace damage (space before tab) on the line before
this one.  It's more obvious in the patch you uploaded to gerrit which
highlights this in red:

https://chromium-review.googlesource.com/#/c/213967/5/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt

Did you run your patches through checkpatch before submitting?

-Doug
