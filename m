From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 3 May 2013 08:26:34 +0200
Subject: [PATCH 4/5] ARM: dts: add device tree source for imx6sl SoC
In-Reply-To: <1367552995-31777-5-git-send-email-shawn.guo@linaro.org>
References: <1367552995-31777-1-git-send-email-shawn.guo@linaro.org>
 <1367552995-31777-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <5183589A.5090109@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.05.2013 05:49, Shawn Guo wrote:
> Add SoC level device tree source for imx6sl.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>   arch/arm/boot/dts/imx6sl.dtsi |  777 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 777 insertions(+)
>   create mode 100644 arch/arm/boot/dts/imx6sl.dtsi
>
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> new file mode 100644

Just as a proposal do discuss: What's about to move the existing 
imx6qdl.dtsi to a imx6.dtsi and include it in

imx6q.dtsi
imx6dl.dtsi
imx6sl.dtsi

then?

> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               interrupt-parent = <&intc>;
> +               ranges;
> +
> +               L2: l2-cache at 00a02000 {
> +                       compatible = "arm,pl310-cache";
> +                       reg = <0x00a02000 0x1000>;
> +                       interrupts = <0 92 0x04>;
> +                       cache-unified;
> +                       cache-level = <2>;
> +               };
The arm,tag-latency and arm,data-latency we recently added for the other 
SoCs are missing here?

Best regards

Dirk
