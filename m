From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 00:33:31 -0700
Subject: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
In-Reply-To: <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <152153121123.254778.13134751025860491351@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sricharan R (2018-03-19 20:58:47)
> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>

That is an odd place for a reviewed-by tag.

> Adds missing memory, reserved-memory nodes.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 28 +++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
> index e413b21e..ad0fbc9 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
> @@ -20,6 +20,34 @@
>         model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK01.1";
>         compatible = "qcom,ipq4019";
>  
> +       memory {
> +               device_type = "memory";
> +               reg = <0x80000000 0x10000000>; /* 256MB */
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               rsvd1 at 87000000 {
> +                       /* Reserved for other subsystem */
> +                       reg = <0x87000000 0x500000>;
> +                       no-map;
> +               };
> +
> +               wifi_dump at 87500000 {
> +                       reg = <0x87500000 0x600000>;
> +                       no-map;
> +               };
> +
> +               rsvd2 at 87B00000 {

Lowercase hex please.

> +                       /* Reserved for other subsystem */
> +                       reg = <0x87B00000 0x500000>;
> +                       no-map;
> +               };
> +       };
