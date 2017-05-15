From: robh@kernel.org (Rob Herring)
Date: Mon, 15 May 2017 16:41:38 -0500
Subject: [PATCH v3 1/3] SoC: es8328-i2c: Add compatible for ES8323
In-Reply-To: <20170512132227.24916-10-romain.perier@collabora.com>
References: <20170512132227.24916-1-romain.perier@collabora.com>
 <20170512132227.24916-10-romain.perier@collabora.com>
Message-ID: <20170515214138.u63u7j53jogk3prm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 03:22:25PM +0200, Romain Perier wrote:
> This commit adds a compatible string for everest,es8323. This is an
> audio codec that is compatible with es8328 and can be found for example
> on the Firefly-RK3288 board.

If it is compatible with the es8328, then that should be a fallback and 
you don't need the driver change.

> 
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/sound/es8328.txt | 5 ++++-
>  sound/soc/codecs/es8328-i2c.c                      | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/es8328.txt b/Documentation/devicetree/bindings/sound/es8328.txt
> index 33fbf058c997..86b6d6e99732 100644
> --- a/Documentation/devicetree/bindings/sound/es8328.txt
> +++ b/Documentation/devicetree/bindings/sound/es8328.txt
> @@ -4,7 +4,10 @@ This device supports both I2C and SPI.
>  
>  Required properties:
>  
> -  - compatible  : Should be "everest,es8328" or "everest,es8388"
> +  - compatible  : Should be one of the following:
> +	- "everest,es8323"

So this would be '"everest,es8323", "everest,es8328"' instead.

> +	- "everest,es8328"
> +	- "everest,es8388"
>    - DVDD-supply : Regulator providing digital core supply voltage 1.8 - 3.6V
>    - AVDD-supply : Regulator providing analog supply voltage 3.3V
>    - PVDD-supply : Regulator providing digital IO supply voltage 1.8 - 3.6V
