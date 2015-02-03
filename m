From: manuel.lauss@gmail.com (Manuel Lauss)
Date: Tue, 3 Feb 2015 15:40:45 +0100
Subject: [RFC PATCH] ASoC: wm8731: let codec to manage clock by itself
In-Reply-To: <20150203124441.GK21293@sirena.org.uk>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
 <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
 <20150203124441.GK21293@sirena.org.uk>
Message-ID: <CAOLZvyEVQmqg9Jn5Kt_2m5K0-taJcGf6mweK4T=fwKOwn-Ovxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 3, 2015 at 1:44 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 03, 2015 at 08:54:57AM +0100, Manuel Lauss wrote:
>
>> +    wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
>> +    if (IS_ERR(wm8731->mclk)) {
>> +        wm8731->mclk = NULL;
>> +        dev_warn(&spi->dev, "assuming static MCLK\n");
>> +    }
>
> This is broken for both deferred probe and in the case where the clock
> API genuinely returns a NULL clock.  Other than that it's the kind of
> thing that we've done for some other drivers, though it's not good to
> have to do this.  Check them for correct behaviour.

Hm, so the only option is to create the simples possible 12MHz clk object?

Manuel
