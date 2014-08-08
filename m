From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 08 Aug 2014 15:29:30 +0200
Subject: [RFC 4/5] ARM: dts: add pinctrl support to Exynos5410
In-Reply-To: <1406549892-5558-5-git-send-email-afaerber@suse.de>
References: <1406549892-5558-1-git-send-email-afaerber@suse.de>
 <1406549892-5558-5-git-send-email-afaerber@suse.de>
Message-ID: <53E4D0BA.7050106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please see my comment inline.

On 28.07.2014 14:18, Andreas F?rber wrote:
> From: Hakjoo Kim <ruppi.kim@hardkernel.com>
> 
> Add the required pin configuration support to Exynos5410 using pinctrl
> interface.

[snip]

> +	pinctrl_0: pinctrl at 13400000 {
> +		compatible = "samsung,exynos5410-pinctrl";
> +		reg = <0x13400000 0x1000>;
> +		interrupts = <0 45 0>;

I believe you are missing the wake-up IRQ controller node here, which is
needed to handle the interrupts of EINTW (gpxN) banks.

Best regards,
Tomasz
