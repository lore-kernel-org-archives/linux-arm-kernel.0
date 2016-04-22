From: joel@jms.id.au (Joel Stanley)
Date: Fri, 22 Apr 2016 15:02:35 +0930
Subject: [PATCH v2 10/11] arm: Add Aspeed machine
In-Reply-To: <20160422052005.GA4520@afzalpc>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-11-git-send-email-joel@jms.id.au>
 <6245614.OXDTEyrM2z@wuerfel>
 <1461277737.3135.14.camel@kernel.crashing.org>
 <1461279774.3135.21.camel@kernel.crashing.org>
 <20160422052005.GA4520@afzalpc>
Message-ID: <CACPK8XcA26ydu+0YVeUoEGKEe5ck_wqNUP+GDUVmL_s3-Tp2Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 2:50 PM, Afzal Mohammed <afzal.mohd.ma@gmail.com> wrote:
> On Fri, Apr 22, 2016 at 09:02:54AM +1000, Benjamin Herrenschmidt wrote:
>> On Fri, 2016-04-22 at 08:28 +1000, Benjamin Herrenschmidt wrote:
>
>> > It may or may not be already correct, you don't necessarily have a
>> > serial enabled bootloader or it might be using a UART driver that
>> > doesn't use the 'standard' divisors etc... This just sanitizes it.
>
>> On a second thought ... if we chose to not support random crap vendor
>> uboots, we could make it a requirement that this register is already
>> set appropriately by the bootloader to match what's in the device-tree
>> I suppose...
>
> ARM Linux expects bootloader to initialize one serial port
> (Documentation/arm/Booting). Though mentioned as optional, recommended
> so far haven't seen one w/o that. And to debug at early boot stage
> like in assembly and where uart driver is not yet up, this helps in
> being able to debug w/o jtag.

I did some testing and on the palmetto we still get console with our
u-boot, so I'll drop the divisor change.

Cheers,

Joel
