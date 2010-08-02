From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 2 Aug 2010 19:40:12 +0300
Subject: [PATCH v2 00/20] native support for wl1271 on ZOOM
In-Reply-To: <AANLkTikPSp0_S8kSFmeZJ0qLR3DHKBN=iW_As5891a6v@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<20100726193028.GG3903@tuxdriver.com>
	<1280736987.17809.18.camel@chilepepper>
	<20100802114256.GE12293@atomide.com>
	<AANLkTikvtMbqUdwHtCtdL2xXbQh64pxjApo6ZH6hAXnP@mail.gmail.com>
	<AANLkTimaSeLqowRHSCivGXTiSE7NatNTR=jLWQYsSo-6@mail.gmail.com>
	<AANLkTikPSp0_S8kSFmeZJ0qLR3DHKBN=iW_As5891a6v@mail.gmail.com>
Message-ID: <AANLkTi=2T_fdQh3KVJffkRw3k7ETAzC65xFE7wp+8Orn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vitaly,

On Mon, Aug 2, 2010 at 7:19 PM, Vitaly Wool <vitalywool@gmail.com> wrote:
> On Mon, Aug 2, 2010 at 5:59 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>
>> Check out patch no. 9:
>
> sorry for the confusion. However, I guess if the platform doesn't
> supply this value, we'll just consider it 0? Without any warning,
> right?
>
> The problem is, we can't really distinguish between this field not set
> and value zero, and that means something is wrong with the design. The
> easiest way is probably changing the clock ids to start with 1.

I don't think it's a huge deal as adding new devices on board files is
anyway something that is done carefully and not so often. Btw, we have
this kind of mechanism in other locations of the kernel as well and it
doesn't seem to be problematic (e.g. spi->chip_select, spi->mode,
spi->irq, ...).

Having said that I don't mind applying your proposal either and
pushing those defines by 1 in the driver. Luca what do you think ?

Thanks,
Ohad.

>
> Thanks,
> ? Vitaly
>
