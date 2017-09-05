From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Sep 2017 11:03:04 +0200
Subject: [PATCH] ASoC: improve RT5514 dependencies
In-Reply-To: <20170801142117.oc3owynj74g5bmyi@sirena.org.uk>
References: <20170731083217.4142512-1-arnd@arndb.de>
 <s5hh8xt0xwy.wl-tiwai@suse.de>
 <20170801142117.oc3owynj74g5bmyi@sirena.org.uk>
Message-ID: <CAK8P3a1PgN=XmAuKrFGT50f4otXzRsPqjYM3bjjKU3DgY7wWLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 1, 2017 at 4:21 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 31, 2017 at 11:15:57AM +0200, Takashi Iwai wrote:
>
>> IMO, flipping the dependency looks saner to me.  The SPI function call
>> is a kind of add-on, after all.
>
> Yes, that's definitely the intention of the code.

I just ran into the same problem again on randconfig testing, after
the bug had been
gone before my vacation:

    sound/soc/codecs/rt5514.o: In function `rt5514_dsp_voice_wake_up_put':
    rt5514.c:(.text+0x2068): undefined reference to `rt5514_spi_burst_write'
    rt5514.c:(.text+0x20c8): undefined reference to `rt5514_spi_burst_write'

Is anyone looking into this? My original patch
(https://patchwork.kernel.org/patch/9871255/) still fixes it but needs a
minor change to apply now. When I last looked into changing
the dependency in the code, I couldn't quite figure out how to
do it there.

         Arnd
