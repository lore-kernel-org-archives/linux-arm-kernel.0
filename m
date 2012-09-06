From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Sep 2012 12:13:11 +0200
Subject: [PATCH 2/2] ARM: dts: exynos4: allow i2c0 bus to be configured
 using pinctrl interface
In-Reply-To: <1346923381-14144-3-git-send-email-thomas.abraham@linaro.org>
References: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
 <1346923381-14144-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <5320531.svfjn4BD9X@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thursday 06 of September 2012 14:53:01 Thomas Abraham wrote:
>  		compatible = "samsung,s3c2440-i2c";
>  		reg = <0x13860000 0x100>;
>  		interrupts = <0 58 0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c0_bus>;

If pinctrl-names property is omitted then the state index is used as a name 
(e.g. pinctrl-0 would be named "0"). Maybe it would be better to use this 
approach (with respective adjustment in first patch)? What do you think?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
