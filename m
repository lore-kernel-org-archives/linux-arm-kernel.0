From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Nov 2012 17:50:54 +0900
Subject: [PATCH v5 1/3] ARM: at91: atmel-ssc: add pinctrl support
In-Reply-To: <1352706028-750-2-git-send-email-voice.shen@atmel.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-2-git-send-email-voice.shen@atmel.com>
Message-ID: <20121113085052.GR18224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 03:40:25PM +0800, Bo Shen wrote:

> +				ssc0 {
> +					pinctrl_ssc0_tx: ssc0_tx-0 {
> +						atmel,pins =
> +							<1 16 0x1 0x1	/* PB16 periph A with pull up */
> +							 1 17 0x1 0x1	/* PB17 periph A with pull up */
> +							 1 18 0x1 0x1>;	/* PB18 periph A with pull up */
> +					};

Do we really want the pull ups here?  Normally CMOS devices don't have
pulls, or the pulls are disabled during normal operation, as otherwise
when the logic level is different to whatever the pull is doing power is
wasted driving against the resistor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/a2a1b7e3/attachment.sig>
