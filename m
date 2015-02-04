From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 4 Feb 2015 11:45:29 +0800
Subject: [RFC PATCH] ASoC: wm8731: let codec to manage clock by itself
In-Reply-To: <20150203162128.GP21293@sirena.org.uk>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
 <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
 <20150203124441.GK21293@sirena.org.uk>
 <CAOLZvyEVQmqg9Jn5Kt_2m5K0-taJcGf6mweK4T=fwKOwn-Ovxg@mail.gmail.com>
 <20150203162128.GP21293@sirena.org.uk>
Message-ID: <54D195D9.4090101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 02/04/2015 12:21 AM, Mark Brown wrote:
> On Tue, Feb 03, 2015 at 03:40:45PM +0100, Manuel Lauss wrote:
>> On Tue, Feb 3, 2015 at 1:44 PM, Mark Brown <broonie@kernel.org> wrote:
>
>>>> +    wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
>>>> +    if (IS_ERR(wm8731->mclk)) {
>>>> +        wm8731->mclk = NULL;
>>>> +        dev_warn(&spi->dev, "assuming static MCLK\n");
>>>> +    }
>
>>> This is broken for both deferred probe and in the case where the clock
>>> API genuinely returns a NULL clock.  Other than that it's the kind of
>>> thing that we've done for some other drivers, though it's not good to
>>> have to do this.  Check them for correct behaviour.
>
>> Hm, so the only option is to create the simples possible 12MHz clk object?
>
> Well, that's the best option in general.  You can get away with just
> making sure that -EPROBE_DEFER is handled and that IS_ERR() is used to
> check for an invalid clock but if you can define a clock that's even
> better (and should be pretty painless), we're going to want to do that
> transition at some point.

Do you mean I send my RFC patch as the formal patch, and let other 
boards which use the wm8731 to add clk object, am I right?

Best Regards,
Bo Shen
