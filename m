From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 11 Mar 2012 11:40:15 +0000
Subject: [PATCH 2/4] Add imx3sound sound support.
In-Reply-To: <1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20120311114014.GB3233@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 03:55:14PM +0100, Philippe R?tornaz wrote:

> +static int imx3sound_hifi_hw_free(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

Remove all empty functions.

> +	imx3sound_snd_device = platform_device_alloc("soc-audio", -1);
> +	if (!imx3sound_snd_device)
> +		return -ENOMEM;

No soc-audio usage, use snd_soc_register_card() from a platform device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120311/671bbcbf/attachment-0001.sig>
