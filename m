From: hramrach@gmail.com (Michal Suchanek)
Date: Sun, 5 Jun 2016 13:27:11 +0200
Subject: [linux-sunxi] Re: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <20160602142649.GJ2282@sirena.org.uk>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk>
 <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
 <20160530155016.GO29837@sirena.org.uk> <20160601180056.GA4908@lukather>
 <1464842546.23881.3.camel@plaes.org>
 <CAOMqctRMi8Zuwqvakka8LkgvecWVAfzUcER9+ui9WBYS78fWtQ@mail.gmail.com>
 <20160602142649.GJ2282@sirena.org.uk>
Message-ID: <CAOMqctQwFif=yFF1snfZJc7+sGS7wcC-6oNTCfjW_MSUWHw+xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 June 2016 at 16:26, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jun 02, 2016 at 02:14:26PM +0200, Michal Suchanek wrote:
>> On 2 June 2016 at 06:42, Priit Laes <plaes@plaes.org> wrote:
>> > On Wed, 2016-06-01 at 20:00 +0200, Maxime Ripard wrote:
>
>> > Actually it non-DMA case works fine if you don't need SPI transfers
>> > larger than SUN4I_FIFO_DEPTH - 1, which is 63 bytes.
>
>> > This was addressed by this patch, but was never applied:
>> > http://permalink.gmane.org/gmane.linux.kernel.spi.devel/18950
>
>> And the code added in that patch will never run unless you
>
>> 1) use long spi transfers
>> 2) compile in/load SPI without DMA support
>
>> There is no reason for doing 2) since we have do DMA support for sunxi.
>
> Well, presumably such code exists and is being worked on?

Which code are you referring to?

This is a reply to patch which adds DMA support to the SPI driver so
that it can work for arbitrarily long transfers.

So there is code for fully working driver.

>
>> So that's another code path that needs maintenance and testing and
>> likely will not get it.
>
> Oh, come on.  You might not want to use it yourself but the chances are
> that someone will want to use it just like the situation with all the
> other SPI drivers.  It's a perfectly reasonable and sensible feature to
> support upstream.

Is it?

Once we have *one* driver that works for arbitrarily long transfers
and it works out of the box with the board defconfig 99% of people who
will use the SPI driver for anything will use this driver. Any other
variant will go untested.

And for the driver to also work without DMA you have to *tell* it to
probe without DMA because it cannot know you are not going to load a
DMA driver later.

>
> I really do not understand why there is such a strong desire to have
> these devices be a special snowflake here, the worst that's likely to
> happen here is that you're going to end up having to either remove the
> DMA controller from the DT or load the driver for it neither of which
> seem like the end of the world.

Why would you do that?

Thanks

Michal
