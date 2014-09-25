From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 24 Sep 2014 17:10:05 -0700
Subject: [PATCH v2] ARM: dts: Add initial DTS file for Sony Xperia Z1
In-Reply-To: <5422DF46.90306@sonymobile.com> (Tim Bird's message of "Wed, 24
 Sep 2014 08:12:06 -0700")
References: <5422DF46.90306@sonymobile.com>
Message-ID: <7h61gck1b6.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

Tim Bird <tim.bird@sonymobile.com> writes:

> This DTS has support for the Sony Xperia Z1 phone (codenamed Honami).
> This first version of the DTS supports just a serial console.
>
> changes from v1
>  - removed qcom,msm-id attribute
>  - removed mis-capitalized Qualcomm word
>  - changed dts file name
>  - added board-specific compatible-string
>
> Signed-off-by: Tim Bird <tim.bird@sonymobile.com>

[...]

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b8c5cd3..0c2702e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -343,7 +343,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8074-dragonboard.dtb \
>  	qcom-apq8084-mtp.dtb \
>  	qcom-msm8660-surf.dtb \
> -	qcom-msm8960-cdp.dtb
> +	qcom-msm8960-cdp.dtb \
> +	qcom-msm8974-sony-honami-xperia.dtb

This doesn't compile becase the filename added is xperia-honami (not
honami-xperia)

After fixing that up, I was able to test it on my Z1 (Thanks Tim/Bjorn!)
but found I needed to add in the qcom,msm-id stuff first.  I guess that
will be remedied with the updated mkbootimg tool, correct?

Anyways, after fixing the filename, feel free to add:

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
