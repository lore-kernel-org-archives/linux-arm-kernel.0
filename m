From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 28 May 2012 07:43:09 +0200
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <m3bol9ibxb.fsf@intrepid.localdomain>
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
 <201205231743.50262.arnd@arndb.de>
 <87396qbtrx.fsf@lebrac.rtp-net.org>
 <m3bol9ibxb.fsf@intrepid.localdomain>
Message-ID: <20120528054309.GA6524@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 27, 2012 at 10:52:48PM +0200, Krzysztof Halasa wrote:
> Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:
> 
> >> So has every kernel since 3.1 been broken, or is it just broken now
> >> but a good idea to backport anyway?
> >
> > every kernel since 3.1 (even 3.1-rc-something). Would be nice to see
> > this issue fixed as similar patches have been sent from time to time but
> > never been merged.
> 
> Is it really that bad? I'm using IXP425 with 3.2 and it definitely
> compiles (and works). Extra patches maybe? I can't see anything obvious.

[Sigh] 

Yes, it is really that bad. Try the following:

1. export kernel with tag v3.2
2. make ixp4xx_defconfig
3. make

You will see:

  CC      arch/arm/mach-ixp4xx/nslu2-setup.o
In file included from arch/arm/mach-ixp4xx/include/mach/gpio.h:72,
                 from /tmp/linux-v3.2/arch/arm/include/asm/gpio.h:5,
                 from include/linux/gpio.h:30,
                 from arch/arm/mach-ixp4xx/nslu2-setup.c:19:
include/asm-generic/gpio.h: In function 'gpio_get_value_cansleep':
include/asm-generic/gpio.h:212: error: implicit declaration of function '__gpio_get_value'
include/asm-generic/gpio.h: In function 'gpio_set_value_cansleep':
include/asm-generic/gpio.h:218: error: implicit declaration of function '__gpio_set_value'
make[1]: *** [arch/arm/mach-ixp4xx/nslu2-setup.o] Error 1

Richard
