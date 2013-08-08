From: zonque@gmail.com (Daniel Mack)
Date: Thu, 08 Aug 2013 12:39:35 +0200
Subject: [PATCH 17/20] ASoC: pxa: pxa-pcm-lib: switch over to
 snd-soc-dmaengine-pcm
In-Reply-To: <20130808103510.GV6427@sirena.org.uk>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-18-git-send-email-zonque@gmail.com>
 <20130807160743.GI6427@sirena.org.uk> <5202718F.2050507@gmail.com>
 <20130807163258.GL6427@sirena.org.uk> <52035463.1030909@gmail.com>
 <52035A81.6090903@metafoo.de> <52035EF0.1030208@gmail.com>
 <20130808093628.GS6427@sirena.org.uk> <5203683C.2000904@gmail.com>
 <20130808103510.GV6427@sirena.org.uk>
Message-ID: <52037567.2000805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.2013 12:35, Mark Brown wrote:
> On Thu, Aug 08, 2013 at 11:43:24AM +0200, Daniel Mack wrote:
> 
>> Hmm. We have this big "if SND_SOC" in sound/soc/Kconfig which prevent
>> that symbol to be selected. In fact, SND_PXA2XX_LIB already selected
>> SND_SOC_DMAENGINE_PCM, but that didn't help.
> 
> Ah, that'd cause problems.
> 
>> And code that is not ASoC specific should live outside of sound/soc, no?
> 
> Yeah, OTOH it's pretty much entirely for ASoC and it'd be less churn.
> No problem to move it though, but please leave in the files pattern for
> ASoC.

So you'd be unhappy with this?

  https://github.com/zonque/linux/commit/77eaba6ed
