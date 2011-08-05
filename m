From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Aug 2011 15:19:25 +0200
Subject: [RFC] using amba_pl08x driver for s3c64xx SoCs
In-Reply-To: <CAGOxZ53edhKA=VbhJJKG--LoG6P8Y+ubKdH5-4woDgBEbTdtVQ@mail.gmail.com>
References: <CAGOxZ50Rz3ynmkuoJb9Pgc0b1pG++-CB9kUtU92zKYtfP3jtRg@mail.gmail.com>
	<CACRpkdasYKx8C7fR1heiQDnJgJMvLa1VuQNhQ+gu5F6ea7d3oA@mail.gmail.com>
	<CAGOxZ53edhKA=VbhJJKG--LoG6P8Y+ubKdH5-4woDgBEbTdtVQ@mail.gmail.com>
Message-ID: <CACRpkdaYxbgqYZZSgRJmfBDWPyp-SQrviK50UvHrkTCO=B=6NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2011 at 1:10 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:

>>> @@ -1953,7 +2048,7 @@ static int pl08x_probe(struct amba_device *adev,
>>> const struct amba_id *id)
>>> ? ? ? ? ? ? ? ?spin_lock_init(&ch->lock);
>>> ? ? ? ? ? ? ? ?ch->serving = NULL;
>>> ? ? ? ? ? ? ? ?ch->signal = -1;
>>> - ? ? ? ? ? ? ? dev_info(&adev->dev,
>>> + ? ? ? ? ? ? ? dev_dbg(&adev->dev,
>>> ? ? ? ? ? ? ? ? ? ? ? ? "physical channel %d is %s\n", i,
>>> ? ? ? ? ? ? ? ? ? ? ? ? pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
>>> ? ? ? ?}
>>
>> Check Russells and Vireshs recent patches, I think they have already
>> fixed up a lot of debug prints.
>>
> I have a concern here, let say if the dev_dbg is enabled, first call
> to pl08x_phy_channel_busy() with ch->serving=NULL will give me NULL
> pointer dereferencing crash.
> please see pl08x_phy_channel_busy() definition.
> Does this dbg really needed (or we can remove this), if yes, then how
> to handle this case?
> Please suggest.

Alter pl08x_phy_channel_busy() to return false immediately if
ch->serving == NULL?

Please make a separate patch for this, since it's an obvious bug that
should be fixed ASAP.

Thanks,
Linus Walleij
