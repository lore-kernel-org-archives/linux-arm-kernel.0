From: stigge@antcom.de (Roland Stigge)
Date: Fri, 28 Sep 2012 11:23:37 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <20120928090848.GX17667@game.jcrosoft.org>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <20120928024744.GV17667@game.jcrosoft.org> <50654E57.3080201@antcom.de>
 <20120928075145.GW17667@game.jcrosoft.org> <50656522.1050900@antcom.de>
 <20120928090848.GX17667@game.jcrosoft.org>
Message-ID: <50656C99.50204@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 11:08 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> Good idea! Talking about the public API (your above gpio_set_block()):
>> *gpios is a list of GPIOs, but set is still bitmapped (mapped onto the
>> list specified in *gpios)? To prevent confusion about what the size
>> argument means (number of gpios in *gpios _or_ number of bytes in the
>> bitmap *set) - wouldn't it be clearer to have a "bool *set" and "bool
>> *values" list?
> public API list of gpio as example
> 
> gpios = {1, 33, 34, 55};
> set = {1, 0, 0 ,1};
> 
> gpio_set_blocks(gpios, set, 4);
> 
> private you do just provide the array related to the gpio_chip
> lets assume 4 bank with 32 gpio each
> 
> gpio0 = {1};
> set0 = {1};
> 
> gpio1 = {33, 34};
> set1 = {0, 0};
> 
> gpio2 = {55};
> set2 = {1};
> 
> set_blocks(gpio_chip0, gpio0, set0, 1);
> set_blocks(gpio_chip1, gpio1, set1, 2);
> set_blocks(gpio_chip2, gpio2, set2, 1);

Good.

For the internal driver API (gpio_chip), we even don't really need the
first argument (gpio_chip) since we can infer it from the gpios.

Will provide an update.

Roland
