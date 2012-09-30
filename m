From: stigge@antcom.de (Roland Stigge)
Date: Sun, 30 Sep 2012 12:34:55 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <20120929195754.GC17667@game.jcrosoft.org>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <20120928024744.GV17667@game.jcrosoft.org> <50654E57.3080201@antcom.de>
 <20120928075145.GW17667@game.jcrosoft.org> <50656522.1050900@antcom.de>
 <20120928090848.GX17667@game.jcrosoft.org>
 <20120928102822.GY17667@game.jcrosoft.org> <50658AD0.1050501@antcom.de>
 <20120928160105.GA17667@game.jcrosoft.org> <5065ED4F.5070700@antcom.de>
 <20120929195754.GC17667@game.jcrosoft.org>
Message-ID: <5068204F.6090606@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/09/12 21:57, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> Problem here is that it's only an intermediate format since hardware
>> often needs special preparation of the data.
>>
>> But will evaluate what makes most sense.
> the key point here is to avoid to manipualte data each time we call
> gpio_block_set
> 
> hardware specific will have to be handle at driver level

Understand, thanks! I'm just trying to prevent overly complex API because:

* In our discussed scheme, the driver still needs to convert the data bits
* In practice, the block gpio API is especially useful for use on single
gpio_chips (only there, a real simultaneous i/o is possible anyway)
* Wouldn't introduce this kind of optimization in lack of measurable
improvement
* The actual i/o data bits still need handling, generating a bit CPU
load anyway.

Trying to provide as simple API as possible.

Roland
