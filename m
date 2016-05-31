From: hramrach@gmail.com (Michal Suchanek)
Date: Tue, 31 May 2016 16:19:28 +0200
Subject: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <20160531132706.GC29837@sirena.org.uk>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk>
 <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
 <20160530155016.GO29837@sirena.org.uk>
 <CAOMqctQijjO2amwSmSMGp96KBRGrLb0fvXRwnybOEqvV3-HZ0g@mail.gmail.com>
 <20160531132706.GC29837@sirena.org.uk>
Message-ID: <CAOMqctSWnbUaOveMUhz+yOJqTOK4EhDd5jUqKoHCohfndNAjWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2016 at 15:27, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 31, 2016 at 12:44:54PM +0200, Michal Suchanek wrote:
>> On 30 May 2016 at 17:50, Mark Brown <broonie@kernel.org> wrote:
>> > On Mon, May 30, 2016 at 05:28:10PM +0200, Michal Suchanek wrote:
>
>> >> It's what the driver did to start with and it was requested to fall
>> >> back to non-DMA in the case DMA is not available.
>
>> > Why?  I really can't see any sensible use case for this that doesn't
>> > have a better solution available.
>
>> Of course, the solution is to compile in the DMA driver.
>
>> It's been argued that some drivers which use only short transfers will
>> just work.
>
> With nothing else in the system that needs DMA?  It's making the
> performance of the system less reliable for the benefit of a very narrow
> use case.

Some of the platform devices have dedicated DMA *controller* built
into the device IP so the DMA engine really is optional on many sunxi
devices. Besides SPI you definitely need the DMA engine for audio. You
probably don't need it for storage and graphics. I don't have any idea
if it's used for USB and Ethernet.

Thanks

Michal
