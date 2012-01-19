From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 19 Jan 2012 10:53:07 -0700
Subject: [PATCH] RFC: spi/sa1100: rewrite the SA1100 SPI driver
In-Reply-To: <CACRpkdYdwKmrL6K9P05COxMVRgHECj_4CUE9COYiuFsQj5N39g@mail.gmail.com>
References: <1326841236-25178-1-git-send-email-linus.walleij@linaro.org>
 <20120117231314.GA1068@n2100.arm.linux.org.uk>
 <CACRpkdbynmvcjOY=7_6wK3YTJHpS16Y0fU-Ka3-qw6Vt+eXy0A@mail.gmail.com>
 <20120118123037.GF1068@n2100.arm.linux.org.uk>
 <CACRpkdYdwKmrL6K9P05COxMVRgHECj_4CUE9COYiuFsQj5N39g@mail.gmail.com>
Message-ID: <CACxGe6sx59tDyH_32GkjnsYif_kJi=R64pV0_7DD5=9WUsfEYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 10:49 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Jan 18, 2012 at 1:30 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Jan 18, 2012 at 01:13:29PM +0100, Linus Walleij wrote:
>
>>> We usually merge drivers for microwire, TI, Motorola ... etc into
>>> drivers/spi as well. It's a good enough fit, the differences are very
>>> small. This is how we configure mode from the PL022 driver platform data:
>>
>> How do you send audio data at 16-bit 2 channel 48kHz continuously with
>> the SPI subsystem?
>
> Can't say because we haven't used it for audio transfers. However
> I am pretty convinced that it'd work because we're running a
> 20 Mbit data link on that SPI port.
>
> To get the high data rates we have an internal message queue in
> the driver that saturates the SPI port. Sometimes we even start to
> run parts of the driver in parallel on two cores: CPU0 is handling
> IRQs from the driver while CPU1 is preparing messages to/from
> the SPI subsystem.

It's not the hardware that is the issue, it is the SPI subsystem which
is absolutely not set up for the kind of low-latency (note: not
high-throughput) transfers that are wanted for audio streams.

g.
