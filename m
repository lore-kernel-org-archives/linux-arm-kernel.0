From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Oct 2013 18:28:14 +0100
Subject: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the sgt15000
 codec.
In-Reply-To: <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131018172814.GT2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:01:14PM +0800, Xiubo Li wrote:

> @@ -883,14 +883,19 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
>  				struct regulator_init_data *init_data,
>  				int voltage)
>  {
> +#ifdef CONFIG_SND_SOC_FSL_SGTL5000
> +	return 0;
> +#else
>  	dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
>  	return -EINVAL;
> +#endif
>  }

If these systems don't actually need the internal regulator then should
they not be trying to enable it?  Alternatively if it's OK to ignore
this then why is this conditional in the board?

If this is something that it's safe to ignore then it should either be
ignored all the time or should be controlled by platform data not by a
compile time #define.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/c86b899c/attachment.sig>
