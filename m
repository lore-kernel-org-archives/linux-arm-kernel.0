From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 20 Jan 2015 00:11:34 +0000
Subject: [PATCH 3/3] ASoC: simple-card: Remove support for setting
 differing DAI formats
In-Reply-To: <1421661297-19654-3-git-send-email-lars@metafoo.de>
References: <1421661297-19654-1-git-send-email-lars@metafoo.de>
 <1421661297-19654-3-git-send-email-lars@metafoo.de>
Message-ID: <87a91ecntk.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Lars

> Having to set different formats on the CPU side and the CODEC side of a DAI
> link is usually indication that something is terribly wrong and in most
> cases is a result of a broken driver that implements a set_fmt() callback
> which does not follow the specification. In the past this feature has been
> used to work around broken drivers, rather than fixing them. We don't really
> want to encourage this, so remove support for setting different formats on
> both ends of the link.
> 
> Along the way switch to static DAI format setup by setting the the dai_fmt
> field of the snd_soc_dai_link rather than calling snd_soc_dai_fmt().
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
(snip)
> +	dai_link->dai_fmt = daifmt;
> +
>  	of_node_put(bitclkmaster);
>  	of_node_put(framemaster);
>  
> @@ -379,13 +367,11 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
>  	dai_link->init = asoc_simple_card_dai_init;
>  
>  	dev_dbg(dev, "\tname : %s\n", dai_link->stream_name);
> -	dev_dbg(dev, "\tcpu : %s / %04x / %d\n",
> +	dev_dbg(dev, "\tcpu : %s / %d\n",
>  		dai_link->cpu_dai_name,
> -		dai_props->cpu_dai.fmt,
>  		dai_props->cpu_dai.sysclk);
> -	dev_dbg(dev, "\tcodec : %s / %04x / %d\n",
> +	dev_dbg(dev, "\tcodec : %s / %d\n",
>  		dai_link->codec_dai_name,
> -		dai_props->codec_dai.fmt,
>  		dai_props->codec_dai.sysclk);

Can you please indicate dai_fmt here anyway ?
I don't care "how to" or "where", but format information is useful for debugging

Best regards
---
Kuninori Morimoto
