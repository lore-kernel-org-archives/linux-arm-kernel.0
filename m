From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jun 2016 17:31:12 +0100
Subject: [alsa-devel] [PATCH v2 6/9] ASoC: mediatek: add mt2701 platform
 driver implementation.
In-Reply-To: <1464929784-5489-7-git-send-email-garlic.tseng@mediatek.com>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
 <1464929784-5489-7-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <20160607163112.GD7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 12:56:21PM +0800, Garlic Tseng wrote:

> +	if (val < 0 || val > MT2701_I2S_NUM) {
> +		dev_err(afe->dev, "%s, num not available, num %d, val %d\n",
> +			__func__, num, val);
> +		return -1;

Real error codes please.

> +static const struct snd_kcontrol_new mt2701_afe_multi_ch_out_asrc3[] = {
> +	SOC_DAPM_SINGLE_AUTODISABLE("Multi ch asrc out3", PWR2_TOP_CON, 7, 1,
> +				    1),
> +};

On/off controls should end in Switch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/23b0b2bb/attachment.sig>
