From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 13 Jul 2010 19:13:10 +0400
Subject: [PATCH v2 0/3] s3c24xx: iPAQ rx1950 series
In-Reply-To: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
References: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
Message-ID: <20100713151310.GA12234@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 10, 2010 at 07:57:46PM +0300, Vasily Khoruzhick wrote:
> This patch series adds more support for iPAQ rx1950 PDA to linux:
> 1. LEDs driver -- it controls blue, green and red LEDs on rx1950
> 2. Battery driver -- adds ability to monitor and charge battery.
> This driver is suitable for H1940 PDA aswell (just need to write
> some machine specific callbacks and get voltage LUTs)
> 
> v2: removed ac registration from s3c_adc_battery driver, use
> pda_power instead for ac support.
> 
> P.S. I prefer to keep own LED triggers for s3c_adc_battery as
> generic power supply triggers do not support LED_HALF brightness
> (on h1940/rx1950 it's used for blink) and I want to keep same
> LEDs behavior as in WinMo.

No, please. Factor out LED triggers addition into a separate patch
and we will discuss* it. That way it won't block this driver merge.

Thanks,

* IIRC, using LED_HALF for blinking is wrong, see
  drivers/leds/leds-pwm.c for a preferred approach.

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
