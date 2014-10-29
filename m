From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 29 Oct 2014 10:07:51 +0800
Subject: [RFC 0/3] ARM: sun9i: Add PRCM clocks and reset controls support
In-Reply-To: <20141028211056.GC9255@lukather>
References: <1413874167-6479-1-git-send-email-wens@csie.org>
 <20141028211056.GC9255@lukather>
Message-ID: <CAGb2v64WOOZ5AeOcG37-95RuKgwDNGn6+CHJGS7uJfB5g=rsbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 29, 2014 at 5:10 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> On Tue, Oct 21, 2014 at 02:49:24PM +0800, Chen-Yu Tsai wrote:
>> This series adds basic support for the PRCM module on sun9i, which
>> has clock and reset controls for the CPU-S or RTC block.
>>
>> The series is marked RFC, because we do not have actual documentation
>> for it. I am assuming the clock tree and register format is the same
>> as the A31 and A23. Obviously we will need to do some testing to verify,
>> which we would need actual peripherals to do.
>>
>> I'm posting this so Maxime can test his pinctrl drivers, and then we
>> can work out how to verify the clocks.
>
> This looks fine overall, but I'm a bit worried that there is too much
> that we don't really know about in this.
>
> Do we need it right now, or can it wait for some A80 documents to be
> released? Maybe we can just postpone this until we have more
> informations on this if it's not going to be used anytime soon anyway.

As I said, the main purpose of getting this out is for you to be able
to test R_PIO. The other reason for it would be for connecting the
AXP PMICs, which would either use I2C or Allwinner's RSB. Either way
we need both PRCM and R_PIO support to do any experimenting.

In short, this series is here so anyone wanting to work on said
peripherals will have something to work with.


Cheers
ChenYu
