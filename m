From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 7 Apr 2011 09:13:06 +0530
Subject: [alsa-devel][PATCH 3/3] SoC: SAMSUNG: Add WM8580 PCM Machine
	driver
In-Reply-To: <1302136270-28776-4-git-send-email-sbkim73@samsung.com>
References: <1302136270-28776-1-git-send-email-sbkim73@samsung.com>
	<1302136270-28776-4-git-send-email-sbkim73@samsung.com>
Message-ID: <BANLkTinOadw2TkNMs2_Lvmskb=yU8XYUuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static struct snd_soc_dai_link smdk_dai[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .name = "WM8580 PAIF PCM RX",
> + ? ? ? ? ? ? ? .stream_name = "Playback",
> + ? ? ? ? ? ? ? .cpu_dai_name = "samsung-pcm.0",
> + ? ? ? ? ? ? ? .codec_dai_name = "wm8580-hifi-playback",
> + ? ? ? ? ? ? ? .platform_name = "samsung-audio",
> + ? ? ? ? ? ? ? .codec_name = "wm8580-codec.0-001b",
> + ? ? ? ? ? ? ? .ops = &smdk_wm8580_pcm_ops,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name = "WM8580 PAIF PCM TX",
> + ? ? ? ? ? ? ? .stream_name = "Capture",
> + ? ? ? ? ? ? ? .cpu_dai_name = "samsung-pcm.0",
> + ? ? ? ? ? ? ? .codec_dai_name = "wm8580-hifi-capture",
> + ? ? ? ? ? ? ? .platform_name = "samsung-audio",
> + ? ? ? ? ? ? ? .codec_name = "wm8580-codec.0-001b",
> + ? ? ? ? ? ? ? .ops = &smdk_wm8580_pcm_ops,
> + ? ? ? },
> +};

IIRC the PCM DAI is connected to Secondary i/f of WM8580
on some SMDKs. Isn't it smdk6410 ?
