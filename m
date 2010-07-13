From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Jul 2010 16:58:12 +0100
Subject: [PATCH v2 0/3] s3c24xx: iPAQ rx1950 series
In-Reply-To: <201007131845.10426.anarsoul@gmail.com>
References: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
	<20100713151310.GA12234@oksana.dev.rtsoft.ru>
	<201007131845.10426.anarsoul@gmail.com>
Message-ID: <20100713155811.GA29710@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 06:45:04PM +0300, Vasily Khoruzhick wrote:

> > * IIRC, using LED_HALF for blinking is wrong, see
> >   drivers/leds/leds-pwm.c for a preferred approach.

> Then it needs complex trigger, so anyway generic power supply simple triggers 
> do not fit in my case. Btw, some LEDs drivers in mainline kernels use LED_HALF 
> for blinking, i.e. leds-pca955x.c and leds-h1940.c.

Are you sure that those drivers are actually blinking?  The code makes
it look like at least pca955x is using PWM to provide brightness control
rather than actually blinking at a human visible rate.
