From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 13:03:04 +0100
Subject: [PATCH v6 8/8] ASoC: sam9x5: get codec MCLK via device tree
In-Reply-To: <1375180329-4860-9-git-send-email-richard.genoud@gmail.com>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-9-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130730120304.GU9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 12:32:09PM +0200, Richard Genoud wrote:

> --- a/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
> @@ -8,6 +8,8 @@ Required properties:
>    - atmel,audio-routing: A list of the connections between audio components.
>      Each entry is a pair of strings, the first being the connection's sink,
>      the second being the connection's source.
> +  - clocks: Must contain an entry for the codec master clock.
> +  - clock-names : Must be "mclk" (clock that feeds the codec master clock)

This should be part of the CODEC binding, not part of the machine driver
binding.  The machine driver should currently have the code to fetch the
clock but since the clock physically goes to the CODEC it should be part
of the CODEC binding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/3e5c84c2/attachment.sig>
