From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Jan 2014 19:31:49 +0000
Subject: [PATCH v2 3/3] Binding: atmel-wm8904: add option to choose clock
In-Reply-To: <1390805726-1841-4-git-send-email-voice.shen@atmel.com>
References: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
 <1390805726-1841-4-git-send-email-voice.shen@atmel.com>
Message-ID: <20140127193149.GQ11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 02:55:26PM +0800, Bo Shen wrote:

> diff --git a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
> index 8bbe50c..2d86e2b 100644
> --- a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
> +++ b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
> @@ -33,6 +33,12 @@ Required properties:
>  
>  Optional properties:
>    - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
> +  - atmel,clk-from-rk-pin: bool property.
> +     - When SSC works in slave mode, according to the hardware design, the
> +       clock can get from TK pin, and also can get from RK pin. So, add
> +       this parameter to choose where the clock from.
> +     - By default the clock is from TK pin, if the clock from RK pin, this
> +       property is needed.

Can this be made a property of the SSC device so that it's available for
all cards using it rather than just this one?  That would also address
the issue with the way the configuration is passed to the controller
that Lars-Peter identified.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/89853ba3/attachment.sig>
