From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Dec 2010 13:39:35 +0000
Subject: [PATCH 2/3] ASoC: CS4271 codec support
In-Reply-To: <20101208130720.GB2716@pulham.picochip.com>
References: <1291809772.31916.4.camel@r60e>
	<20101208130720.GB2716@pulham.picochip.com>
Message-ID: <20101208133935.GI16418@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 01:07:20PM +0000, Jamie Iles wrote:

> Doesn't the dependency on SND_SOC_I2C_AND_SPI mean that you will always have 
> I2C and SPI_MASTER?

It's not a dependency for the CODEC driver at all.  It means that when
SND_SOC_ALL_CODECS is selecting the module it will ensure that a
consistent combination of options is chosen but it is unrelated to use
in machine drivers and doesn't force both to be enabled even when it is
selected.
