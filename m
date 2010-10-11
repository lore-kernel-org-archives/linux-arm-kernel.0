From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 11 Oct 2010 09:22:51 +0900
Subject: [alsa-devel] [PATCH 4/4] ASoC: ep93xx: add Simplemachines Sim.One
	AC97 audio support
In-Reply-To: <cbadad77a7e11b27fedd9e92fe05322291ca1377.1286707213.git.mika.westerberg@iki.fi>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<cbadad77a7e11b27fedd9e92fe05322291ca1377.1286707213.git.mika.westerberg@iki.fi>
Message-ID: <AANLkTi=PAp8pQeVM=GWYVVeKnf2-f+YG2bdSuu5QZH87@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 10, 2010 at 7:54 PM, Mika Westerberg <mika.westerberg@iki.fi> wrote:

> +
> +static struct snd_soc_dai_link simone_dai = {
> + ? ? ? .name ? ? ? ? ? = "AC97",
> + ? ? ? .stream_name ? ?= "AC97 HiFi",
> + ? ? ? .cpu_dai ? ? ? ?= &ep93xx_ac97_dai,
> + ? ? ? .codec_dai ? ? ?= &ac97_dai,
> +};
ASoC no longer works on cpu and codec_dai. You need to only
provide the name of the dais... ASoC does string matching to
link appropriate dais in a link.

You might want to give another thorough look to all of your drivers
under the new ASoC.
