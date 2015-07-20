From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 Jul 2015 16:19:32 -0600
Subject: [PATCH v3 4/4] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <1437424546-30405-5-git-send-email-danindrey@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <1437424546-30405-5-git-send-email-danindrey@mail.ru>
Message-ID: <55AD73F4.2050502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2015 02:35 PM, Andrey Danin wrote:
> NVEC driver was reimplemented to use tegra i2c. Use common i2c bindings
> for NVEC node.

> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts

> +		nvec: nvec at 45 {
> +			compatible = "nvidia,nvec-slave";
> +			reg = <0x45>;

I think you need to or in I2C_OWN_SLAVE_ADDRESS from 
<dt-bindings/i2c/i2c.h> here?
