From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 24 Jun 2010 00:24:16 +0100
Subject: [PATCH] ASoC: DaVinci: Added support for stereo I2S
In-Reply-To: <1277303635-5675-1-git-send-email-lamiaposta71@gmail.com>
	(sfid-20100623_154205_545825_0E9CDE5F)
References: <1277303635-5675-1-git-send-email-lamiaposta71@gmail.com>
	(sfid-20100623_154205_545825_0E9CDE5F)
Message-ID: <ACF70CBE-6096-431C-A5A1-E3700642EB53@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 Jun 2010, at 15:33, Raffaele Recalcati wrote:

> From: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> 
> 	Added audio playback support with [frame sync master - clock master] mode
> 	and with [frame sync master - clock slave].
> 	Clock slave can be important when the external codec need system clock
> 	and bit clock synchronized.
> 	In the clock master case there is a FIXME message in the source code, because we
> 	(Davide and myself) have guessed a frequency of 122000000 that seems the base
> 	to be divided.
> 	This patch has been developed against the
> 		http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
> 	git tree and has been tested on bmx board (similar to dm365 evm, but using
> 	uda1345 as external audio codec).
> 
> Signed-off-by: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> Signed-off-by: Davide Bonfanti <davide.bonfanti@bticino.it>

I'd pretty much echo what Liam said - I'm not 100% sure from your description what the
patch is supposed to do and the code isn't particularly clear either. It *looks* like you're
trying to add a new clock source, but from the description this appears to be an
externally visible clock which makes it very unclear why you have to guess the frequency.
