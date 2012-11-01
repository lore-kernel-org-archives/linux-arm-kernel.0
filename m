From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Nov 2012 14:43:15 +0000
Subject: [Patch v2 3/4] ASoC: atmel-ssc-dai: register platform from DAIs
In-Reply-To: <1351668420-18447-3-git-send-email-voice.shen@atmel.com>
References: <1351668420-18447-1-git-send-email-voice.shen@atmel.com>
 <1351668420-18447-3-git-send-email-voice.shen@atmel.com>
Message-ID: <20121101144315.GM4413@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 03:26:59PM +0800, Bo Shen wrote:

> +Required properties:
> +  - compatible: "atmel,atmel-ssc-dai"
> +  - atmel,dai-master: this dai base on which ssc controller

> +Example:
> +dai: dai {
> +	compatible = "atmel,atmel-ssc-dai";
> +	atmel,dai-master = <&ssc0>;
> +};

This seems to be a purely virtual device which remaps the SSC onto the
Linux audio subsystem?  If that is the case then it shouldn't appear in
the device tree, the machine driver should just directly reference the
SSC and instantiate any devices required in Linux directly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121101/daf7cdde/attachment-0001.sig>
