From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 1 Nov 2018 09:18:34 +0100
Subject: [PATCH] pinctrl: bcm2835: Use define directive for
 BCM2835_PINCONF_PARAM_PULL
In-Reply-To: <20181101004653.7552-1-natechancellor@gmail.com>
References: <20181101004653.7552-1-natechancellor@gmail.com>
Message-ID: <4619d04e-3f17-f1d8-2cca-a9b62f063d75@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.11.18 um 01:46 schrieb Nathan Chancellor:
> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/pinctrl/bcm/pinctrl-bcm2835.c:707:40: warning: implicit
> conversion from enumeration type 'enum bcm2835_pinconf_param' to
> different enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         configs[0] = pinconf_to_config_packed(BCM2835_PINCONF_PARAM_PULL, pull);
>                      ~~~~~~~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
