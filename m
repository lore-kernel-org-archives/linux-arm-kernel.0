From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 12 Jan 2017 18:34:10 +0000
Subject: [QUESTION] Arm64: Query L3 cache info via DT
In-Reply-To: <5874A03A.9000901@huawei.com>
References: <58633494.9030708@huawei.com>
 <81784854-11f8-468a-a280-69be0a714a3b@arm.com> <5874A03A.9000901@huawei.com>
Message-ID: <1e257239-ac1e-949b-b3e7-84228466d892@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/01/17 08:50, Tan Xiaojun wrote:
[...]

> diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> index 4b472a3..aac18c2 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> @@ -215,18 +215,30 @@
> 
>                 cluster0_l2: l2-cache0 {
>                         compatible = "cache";
> +                       next-level-cache = <&die0_l3c>;
>                 };
> 
>                 cluster1_l2: l2-cache1 {
>                         compatible = "cache";
> +                       next-level-cache = <&die0_l3c>;
>                 };
> 
>                 cluster2_l2: l2-cache2 {
>                         compatible = "cache";
> +                       next-level-cache = <&die0_l3c>;
>                 };
> 
>                 cluster3_l2: l2-cache3 {
>                         compatible = "cache";
> +                       next-level-cache = <&die0_l3c>;
> +               };
> +
> +               die0_l3c: l3-cache {
> +                       compatible = "cache";
> +                       cache-size = <16777216>;
> +                       cache-line-size = <64>;
> +                       cache-block-size = <16>;

You need to add cache-level = <3> with v2 patch set to work.

-- 
Regards,
Sudeep
