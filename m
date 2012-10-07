From: stigge@antcom.de (Roland Stigge)
Date: Sun, 07 Oct 2012 22:47:20 +0200
Subject: [PATCH RFC 1/2 v2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <20121007194717.GE12801@game.jcrosoft.org>
References: <1349469387-20580-1-git-send-email-stigge@antcom.de>
 <20121007194717.GE12801@game.jcrosoft.org>
Message-ID: <5071EA58.1030406@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 07/10/12 21:47, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> +This creates a new block of GPIOs as a list of GPIO numbers with the specified
>> +size which are accessible via the returned struct gpio_block and the accessor
>> +functions described below. Please note that you need to request the GPIOs
>> +separately via gpio_request(). An arbitrary list of globally valid GPIOs can be
>> +specified, even ranging over several gpio_chips. Actual handling of I/O
>> +operations will be done on a best effort base, i.e. simultaneous I/O only where
>> +possible by hardware and implemented in the respective GPIO driver. The number
>> +of GPIOs in one block is limited to 32 on a 32 bit system, and 64 on a 64 bit
>> +system.

> this limitation is not acceptable

I guess this depends on what you want to do.

For practical reasons, accessing GPIOs collected in a word is
reasonable, IMO. And according to the replies from Stijn and Linus,
32/64 bit words are acceptable for them.

Can you please show me in which cases you need >32 bit word access (on a
32bit machine)? Practical example? Are there any GPIO controllers where
you can actually get/set 32 lines simultaneously? Then, I'd be happy to
adjust the API. (Actually, I liked Stijn's approach, which should be
reflected in my patch.)

If simultaneousness is not necessary, you can define further blocks with
32 lines each. Since your 32 bit machine will probably do only 32 bits
maximum at once, I can't see a big limit here.

Thanks for considering,

Roland
