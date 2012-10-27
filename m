From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 27 Oct 2012 23:12:05 +0100
Subject: [PATCH 4/5] ASoC: sam9g20_wm8731: convert to device tree support
In-Reply-To: <1350901079-18307-4-git-send-email-voice.shen@atmel.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
 <1350901079-18307-4-git-send-email-voice.shen@atmel.com>
Message-ID: <20121027221204.GL4564@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 06:17:58PM +0800, Bo Shen wrote:
> Covert sam9g20 wm8731 to device tree support
> And enable it through dts file
>   
>   Tested on sam9g20 EK board

This needs to add binding documentation for the board.

> +	dai: dai {
> +		compatible = "atmel,atmel-ssc-dai";
> +		atmel,dai-master = <&ssc0>;
> +	};

This looks wrong - this is a Linux-specific virtual device sitting on
top of the SSC which is the actual physical device.  The usual patterns
would be something like have the machine driver register the DAI based
on the SSC specified in the bindings (much like how you're handling the
platform already).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121027/9129200a/attachment.sig>
