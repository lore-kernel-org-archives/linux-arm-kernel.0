From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Tue, 11 Nov 2014 10:11:25 +0100
Subject: [RFC 2/2] regulator: qcom-rpm: Implement RPM assisted disable
In-Reply-To: <1415659966-16200-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <5461D2BD.2080209@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 10.11.2014 um 23:52 schrieb Bjorn Andersson:
> diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> index 4264021..4671eef 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> @@ -112,6 +112,13 @@ of valid subnodes that can operate on these resources.
>  	Definition: select that the power supply should operate in hysteretic
>  		    mode, instead of the default pwm mode
>  
> +- qcom,rpm-assisted-disable:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: select that the regulator is supplying the active CPU(s)
> +		    and can only be disabled with the assistans from the RPM

"assistance"

> +		    after going to sleep
> +
>  Standard regulator bindings are used inside switch mode power supply subnodes.
>  Check Documentation/devicetree/bindings/regulator/regulator.txt for more
>  details.
> @@ -160,6 +167,13 @@ details.
>  						qcom,rpm-pm8921-nldo,
>  						qcom,rpm-pm8921-nldo1200
>  
> +- qcom,rpm-assisted-disable:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: select that the regulator is supplying the active CPU(s)
> +		    and can only be disabled with the assistans from the RPM

ditto

> +		    after going to sleep
> +
>  Standard regulator bindings are used inside switch low-dropout regulator
>  subnodes.  Check Documentation/devicetree/bindings/regulator/regulator.txt for
>  more details.
> @@ -190,6 +204,13 @@ more details.
>  		    2740000, 2400000, 2130000, 1920000, 1750000, 1600000,
>  		    1480000, 1370000, 1280000, 1200000
>  
> +- qcom,rpm-assisted-disable:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: select that the regulator is supplying the active CPU(s)
> +		    and can only be disabled with the assistans from the RPM

ditto

> +		    after going to sleep
> +
>  Standard regulator bindings are used inside negative charge pump regulator
>  subnodes.  Check Documentation/devicetree/bindings/regulator/regulator.txt for
>  more details.
> @@ -215,6 +236,13 @@ more details.
>  		    QCOM_RPM_PM8921_LVS1 - QCOM_RPM_PM8921_LVS7,
>  		    QCOM_RPM_PM8921_MVS
>  
> +- qcom,rpm-assisted-disable:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: select that the regulator is supplying the active CPU(s)
> +		    and can only be disabled with the assistans from the RPM

ditto

> +		    after going to sleep
> +
>  = EXAMPLE
>  
>  	#include <dt-bindings/mfd/qcom-rpm.h>
[snip]

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
