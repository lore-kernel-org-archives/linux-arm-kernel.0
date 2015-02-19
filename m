From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Feb 2015 18:44:25 +0900
Subject: [PATCH 5/6] ASoC: samsung: Extend Snow driver to support max98089
In-Reply-To: <1424283959-16289-6-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-6-git-send-email-afaerber@suse.de>
Message-ID: <20150219094425.GB3198@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 07:25:58PM +0100, Andreas F?rber wrote:

>  static const struct of_device_id snow_of_match[] = {
> +	{ .compatible = "google,snow-audio-max98089", },
>  	{ .compatible = "google,snow-audio-max98090", },
>  	{ .compatible = "google,snow-audio-max98091", },
>  	{ .compatible = "google,snow-audio-max98095", },

Since we completely ignore the CODEC in the property might it not be
better to just add a plain old snow-audio compatible and bind to that,
that way we don't need these driver updates?  Just the "snow" bit should
be enough to know it's one of this class of machines.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150219/738f8ed8/attachment.sig>
