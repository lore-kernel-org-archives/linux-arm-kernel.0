From: dianders@chromium.org (Doug Anderson)
Date: Mon, 2 Jul 2018 13:12:01 -0700
Subject: [PATCH v2 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
In-Reply-To: <20180702181005.18247-1-mka@chromium.org>
References: <20180702181005.18247-1-mka@chromium.org>
Message-ID: <CAD=FV=VSnKWqeRj-Kr9tkzeuqxm86Ex6E0uT6Qka=EqjurizNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 2, 2018 at 11:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> This adds the spmi-temp-alarm node to pm8998 based on the examples in the
> bindings.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - none
>
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 92bed1e7d4bb..2f4989e7ef68 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -11,6 +11,13 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> +               pm8998_temp: qcom,temp-alarm at 2400 {

Remove "qcom," from the node name (AKA please change to
"temp-alarm at 2400").  Someone internal in Qualcomm seems to have
started this trend so you see it on all downstream kernels, but
upstream device tree isn't supposed to have it.


> +                       compatible = "qcom,spmi-temp-alarm";
> +                       reg = <0x2400 0x100>;

Why are there two numbers for the "reg"?  Should just be 0x2400.


-Doug
