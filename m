From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 Aug 2013 11:22:11 +0100
Subject: [PATCH v11 2/8] ASoC: core: Generic ac97 link reset functions
In-Reply-To: <1376924761-4054-3-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20130820102211.GH30073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 05:05:55PM +0200, Markus Pargmann wrote:
> This patch adds generic ac97 reset functions using pincontrol and gpio
> parsed from devicetree.

Applied, thanks.

> +Required properties:
> + - pinctrl-names: Has to contain following states to setup the correct
> +   pinmuxing for the used gpios:
> +	"ac97-running": AC97-link is active
> +	"ac97-reset": AC97-link reset state
> +	"ac97-warm-reset": AC97-link warm reset state
> + - ac97-gpios: List of gpio phandles with args in the order ac97-sync,
> +   ac97-sdata, ac97-reset

This should really be reviewed on the DT list but never mind.

> +	gpio_direction_output(snd_ac97_rst_cfg.gpio_sync, 0);

These ought to be _cansleep() since there's no need for them to run in
atomic context but that can be fixed up later.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130820/e427fc17/attachment.sig>
