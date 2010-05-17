From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 May 2010 06:46:22 -0700
Subject: [PATCH] NUC900/audio: add nuc900 audio driver support
In-Reply-To: <4BF0E184.204@gmail.com>
References: <4BF01069.6060102@gmail.com>
	<20100517024425.GA2485@opensource.wolfsonmicro.com>
	<4BF0E184.204@gmail.com>
Message-ID: <20100517134622.GA5257@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 02:26:12PM +0800, Wan ZongShun wrote:
> >On Sun, May 16, 2010 at 11:34:01PM +0800, Wan ZongShun wrote:

> >>+	if (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS0) & CODEC_READY))
> >>+		dev_err(nuc900_audio->dev, "AC97 codec cold reset failed!\n");

> >What is this actually checking in the hardware?  Not all CODECs enable
> >the AC97 link by default after a cold reset, the standard allows them to
> >power up in a low power state which will

> The bit 'CODEC_READY' indicates the external AC97 audio CODEC is ready,
> I just forget to implement the warm reset operation, if need, I will do
> it. In addition, Can I add the checking CODEC_READY operation to
> warm reset function?

That sounds fine.  For defensiveness it might be worth checking the
CODEC on register reads and writes too (it'd make diagnostics a bit
easier).

> >>+#define	IIS_EN			0x0002

> >Looks like there's I2S support to come?

> Yes,nuc900 supports both IIS and AC97,but my board only enable AC97 support,
> what's up here?

Nothing, just curious.
