From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 16 Nov 2013 11:39:43 +0200
Subject: [PATCHv5] dmaengine: Add support for BCM2835
In-Reply-To: <CAHp75Vf3CJNgSiSjoZ6dYjRRHWN4bTpMxRTLG37+wwtEsQbq4g@mail.gmail.com>
References: <52864BBC.7000506@koalo.de> <1384537403.14845.131.camel@smile>
 <20131115175155.GQ16735@n2100.arm.linux.org.uk>
 <CAHp75Vf3CJNgSiSjoZ6dYjRRHWN4bTpMxRTLG37+wwtEsQbq4g@mail.gmail.com>
Message-ID: <CAHp75VdvfABJ5C9M4F_RbfGfR5cp8xROzRTCgtkMUvUxoHXS0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Nov 15, 2013 at 7:51 PM, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>>
>> On Fri, Nov 15, 2013 at 05:43:45PM +0000, Shevchenko, Andriy wrote:
>>
>> > > +module_platform_driver(bcm2835_dma_driver);
>> >
>> > Is it possible to get driver initialized after that one that uses it?
>>
>> Doesn't quite make sense.  If you're asking whether other drivers can
>> try to make use of this driver before it's initialised, then the answer
>> is no.  We have mechanisms to cope with that - see deferred probing.

The reason why I was asking about I'm just wondering what we have to
do with existing drivers. Shall we convert them to be initialized as
normal platform drivers instead of subsys_initcall?

-- 
With Best Regards,
Andy Shevchenko
