From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 8 Dec 2010 14:47:57 +0000
Subject: [PATCH 2/3] ASoC: CS4271 codec support
In-Reply-To: <20101208133935.GI16418@rakim.wolfsonmicro.main>
References: <1291809772.31916.4.camel@r60e>
	<20101208130720.GB2716@pulham.picochip.com>
	<20101208133935.GI16418@rakim.wolfsonmicro.main>
Message-ID: <20101208144757.GD2716@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 01:39:35PM +0000, Mark Brown wrote:
> On Wed, Dec 08, 2010 at 01:07:20PM +0000, Jamie Iles wrote:
> 
> > Doesn't the dependency on SND_SOC_I2C_AND_SPI mean that you will always have 
> > I2C and SPI_MASTER?
> 
> It's not a dependency for the CODEC driver at all.  It means that when
> SND_SOC_ALL_CODECS is selecting the module it will ensure that a
> consistent combination of options is chosen but it is unrelated to use
> in machine drivers and doesn't force both to be enabled even when it is
> selected.
Ahh, thanks for the explanation, I completely misunderstood the way that the 
codecs were selected by the arch's in sound/soc/* and assumed that they were 
user selectable options.

Jamie
