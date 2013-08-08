From: broonie@kernel.org (Mark Brown)
Date: Thu, 8 Aug 2013 11:35:10 +0100
Subject: [PATCH 17/20] ASoC: pxa: pxa-pcm-lib: switch over to
 snd-soc-dmaengine-pcm
In-Reply-To: <5203683C.2000904@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-18-git-send-email-zonque@gmail.com>
 <20130807160743.GI6427@sirena.org.uk> <5202718F.2050507@gmail.com>
 <20130807163258.GL6427@sirena.org.uk> <52035463.1030909@gmail.com>
 <52035A81.6090903@metafoo.de> <52035EF0.1030208@gmail.com>
 <20130808093628.GS6427@sirena.org.uk> <5203683C.2000904@gmail.com>
Message-ID: <20130808103510.GV6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 11:43:24AM +0200, Daniel Mack wrote:

> Hmm. We have this big "if SND_SOC" in sound/soc/Kconfig which prevent
> that symbol to be selected. In fact, SND_PXA2XX_LIB already selected
> SND_SOC_DMAENGINE_PCM, but that didn't help.

Ah, that'd cause problems.

> And code that is not ASoC specific should live outside of sound/soc, no?

Yeah, OTOH it's pretty much entirely for ASoC and it'd be less churn.
No problem to move it though, but please leave in the files pattern for
ASoC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130808/87bb04c1/attachment.sig>
