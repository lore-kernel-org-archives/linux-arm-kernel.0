From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 6 Mar 2017 17:14:56 +0100
Subject: [PATCH 0/2] meson-gxl pinctrl - add the missing PWM pins
In-Reply-To: <20170304212318.27076-1-martin.blumenstingl@googlemail.com>
References: <20170304212318.27076-1-martin.blumenstingl@googlemail.com>
Message-ID: <7aaa5ff1-8c10-2b69-1273-bfdb1783e47b@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2017 10:23 PM, Martin Blumenstingl wrote:
> Due to the lack of a public GXL or GXM datasheet most of the PWM pin
> definitions are currently missing.
> However, the people behind the Khadas VIM boards were kind enough to
> share the PWM pins and their corresponding register offsets and bits
> with me.
> 
> This patch adds all missing PWM pins to the GXL pinctrl driver. The
> upcoming Khadas VIM board support patch only needs PWM_F and PWM_AO_A.
> I still decided to add all PWM pins just in case there's no public GXL
> datasheet release soon.
> 
> 
> Martin Blumenstingl (2):
>   pinctrl: meson: gxl: add the missing PWM pin definitions
>   ARM64: dts: amlogic: meson-gxl: add the missing PWM pins
> 
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 56 ++++++++++++++++++++++++++
>  drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 64 ++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
> 

Tested by running it on the Khadas VIM :

Tested-by: Neil Armstrong <narmstrong@baylibre.com>

and

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
