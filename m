From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Thu, 27 Nov 2014 10:44:23 +0200
Subject: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org>
 <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
Message-ID: <1417077863.10282.3.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, 

On Wed, 2014-11-26 at 22:24 -0700, Lina Iyer wrote:
> 

>  - compatible:
> @@ -14,10 +23,13 @@ PROPERTIES
>         Value type: <string>
>         Definition: shall contain "qcom,saw2". A more specific value should be
>                                                 one of:

Which driver is supposed to handle this property?

> -                               "qcom,saw2-v1"
> -                               "qcom,saw2-v1.1"
> -                               "qcom,saw2-v2"
> -                               "qcom,saw2-v2.1"
> +                       "qcom,saw2-v1"
> +                       "qcom,saw2-v1.1"
> +                       "qcom,saw2-v2"
> +                       "qcom,saw2-v2.1"

Doesn't seems to be used or supported?

> +                       "qcom,apq8064-saw2-v1.1-cpu"
> +                       "qcom,msm8974-saw2-v2.1-cpu"
> +                       "qcom,apq8084-saw2-v2.1-cpu"
> 

<snip>

> -???????regulator at 2099000 {
> +???????power-controller at 2099000 {
>                 compatible = "qcom,saw2";
>                 reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
> +               regulator;
> 

<snip>

> +static const struct of_device_id spm_match_table[] = {
> +       { .compatible = "qcom,msm8974-saw2-v2.1-cpu",
> +                       .data = &spm_reg_8974_8084_cpu },
> +       { .compatible = "qcom,apq8084-saw2-v2.1-cpu",
> +                       .data = &spm_reg_8974_8084_cpu },
> +       { .compatible = "qcom,apq8064-saw2-v1.1-cpu",
> +                       .data = &spm_reg_8064_cpu },
> +       { },
> +};
> +

Regards,
Ivan
