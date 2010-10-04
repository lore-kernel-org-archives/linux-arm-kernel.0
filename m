From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Oct 2010 15:42:00 -0700
Subject: [PATCH 10/10] ASoC: SAMSUNG: Add Machine driver for S/PDIF PCM
	audio
In-Reply-To: <1286194583-19937-1-git-send-email-sw.youn@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286194583-19937-1-git-send-email-sw.youn@samsung.com>
Message-ID: <20101004224159.GA4972@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 09:16:23PM +0900, Seungwhan Youn wrote:

> +/* Audio clock settings are belonged to board specific part. Every
> + * board can set audio source clock setting which is matched with H/W
> + * like this function-'set_audio_clock_heirachy'.
> + */
> +static int set_audio_clock_heirachy(struct platform_device *pdev)
> +{

I'd expect this to be with the other clock configuration code under
arch/arm, especially as it's involving the EPLL which can have fairly
wide usage - it seems better to make sure people working with other,
non-audio, bits of the system are aware of the EPLL usage.
