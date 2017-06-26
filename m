From: romain.perier@collabora.com (Romain Perier)
Date: Mon, 26 Jun 2017 16:00:17 +0200
Subject: [PATCH v3 0/3] Add support for es8323 and hdmi audio to the
 firefly-rk3288
In-Reply-To: <20170512132227.24916-9-romain.perier@collabora.com>
References: <20170512132227.24916-1-romain.perier@collabora.com>
 <20170512132227.24916-9-romain.perier@collabora.com>
Message-ID: <98ec8d72-2977-4347-86b0-4b423b55c434@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

ping,

no other feedbacks (for 2/3 and 3/3)?

Romain


Le 12/05/2017 ? 15:22, Romain Perier a ?crit :
> This set of patches enables support for the es8323 codecs on the
> firefly-rk3288. It adds the required DT definitions to link rockchip-i2s
> to the es8388 analog output. As the support for HDMI audio is also
> built-in in the corresponding ASoC machine driver, HDMI audio output is
> also enabled.
>
> Changes in v3:
>  - Synced DT with the one of the Rock2, the properties have been
>    lexically re-ordered in the right order, I have splitted the
>    headphone pinctrl in two: phone_ctl and hp_det
> Changes in v2:
>  - Adapted DT for the firefly-rk3288 to the ASoC machine driver
>    rk3288-hdmi-analog
>  - Added patch 02/03 to this series
>  - Re-wrote this cover letter
>
> Romain Perier (3):
>   SoC: es8328-i2c: Add compatible for ES8323
>   arm: dts: rockchip: Don't set otp-gpio pinctrl by default in
>     rk3288.dtsi
>   arm: dts: Add support for ES8323 to the Firefly-RK3288
>
>  Documentation/devicetree/bindings/sound/es8328.txt |  5 ++-
>  arch/arm/boot/dts/rk3288-evb.dtsi                  |  4 +++
>  arch/arm/boot/dts/rk3288-firefly.dtsi              | 38 ++++++++++++++++++++++
>  arch/arm/boot/dts/rk3288-veyron.dtsi               |  4 +++
>  arch/arm/boot/dts/rk3288.dtsi                      |  4 ---
>  sound/soc/codecs/es8328-i2c.c                      |  2 ++
>  6 files changed, 52 insertions(+), 5 deletions(-)
>
