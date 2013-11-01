From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Nov 2013 11:50:45 -0700
Subject: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000 codec driver
 about regulator.
In-Reply-To: <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131101185045.GG2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 03:04:52PM +0800, Xiubo Li wrote:
> On VF610 series there are no regulators used, and now whether the
> CONFIG_REGULATOR mirco is enabled or not, for the VF610 audio
> patch series, the board cannot be probe successfully.
> And this patch will solve this issue.

I don't understand what this is for at all, you're just saying there is
a problem you're trying to solve but you don't explain anything about
what the problem is or how your changes address it.

> +#ifndef CONFIG_SND_SOC_FSL_SGTL5000_VF610
>  static int ldo_regulator_register(struct snd_soc_codec *codec,

This is definitely broken, it won't work with multi-platform kernels,
and I don't understand what this is supposed to do - what is the reason
for making this change?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131101/00662d36/attachment.sig>
