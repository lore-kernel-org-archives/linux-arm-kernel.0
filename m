From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Jun 2014 19:46:58 +0100
Subject: [PATCH V2 1/2] ASoC: samsung: Add machine driver for Odroid X2/U3
In-Reply-To: <1403108551-25058-2-git-send-email-s.nawrocki@samsung.com>
References: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
 <1403108551-25058-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140630184658.GE23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 06:22:30PM +0200, Sylwester Nawrocki wrote:

> +struct odroidx2_drv_data odroidx2_drvdata = {
> +	.dapm_widgets		= odroidx2_dapm_widgets,
> +	.num_dapm_widgets	= ARRAY_SIZE(odroidx2_dapm_widgets),
> +};
> +
> +struct odroidx2_drv_data odroidu3_drvdata = {
> +	.dapm_widgets		= odroidu3_dapm_widgets,
> +	.num_dapm_widgets	= ARRAY_SIZE(odroidu3_dapm_widgets),
> +};

> +	ret = snd_soc_of_parse_audio_routing(card, "samsung,audio-routing");
> +	if (ret < 0)
> +		return ret;

Given that the widgets don't have any actions defined and the routing is
all done by DT it might be easier and more flexible to just define all
the widgets all the time and let them hang there if they're not in use,
that way you don't need multiple compatible strings.  If you do that
you're then very close to being able to use simple-card...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/221f13ee/attachment-0001.sig>
