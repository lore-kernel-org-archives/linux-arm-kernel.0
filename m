From: subaparts@yandex.ru (Alexander)
Date: Fri, 10 Dec 2010 00:14:18 +0300
Subject: [PATCH 1/3] ASoC: EP93xx I2S and PCM fixes
In-Reply-To: <20101209123457.GD4469@rakim.wolfsonmicro.main>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1291855051.31916.85.camel@r60e>
	<20101209105443.GA4469@rakim.wolfsonmicro.main>
	<1291897061.31916.149.camel@r60e>
	<20101209123457.GD4469@rakim.wolfsonmicro.main>
Message-ID: <1291929258.16839.17.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,

On Thu, 2010-12-09 at 12:34 +0000, Mark Brown wrote:
> > Always using 32 bit chunks is not a problem for I2S, the codec I use
> > uses less bits too (24), it's permitted by I2S standard.
> 
> It's a problem because it means that the data needs to be laid out in
> memory in 32 bit words which means that a lot of data is going to need
> to be repacked from 16 bit to 32 bit samples which is wasteful.  If the
> hardware can be persuaded to avoid this then that's much better.

BTW, it's how original Cirrus's sound driver had done it's work. Cirrus
programmers had not found a way to overcome this. The datasheets for
EP93xx series cover everything only briefly... The dumbness of EP93xx's
DMA is also the reason why we do not have DMA in serial ports and SSP...

Here we have attached original Cirrus driver:
http://arm.cirrus.com/forum/viewtopic.php?t=3517
Here it is:
http://arm.cirrus.com/forum/download.php?id=240

The function I'm talking about is snd_ep93xx_dma2usr_ratio(), as told in
comments "For audio playback, we convert samples of arbitrary format to
be 32 bit for our hardware".

Best regards,
	Alexander A. Sverdlin.
