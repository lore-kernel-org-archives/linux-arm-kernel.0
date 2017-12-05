From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 5 Dec 2017 15:17:39 -0800
Subject: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64 SoC
In-Reply-To: <20171205080444.zo2rlusqpjyraqcw@flea.lan>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
 <20171205080444.zo2rlusqpjyraqcw@flea.lan>
Message-ID: <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 12:04 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sun, Dec 03, 2017 at 12:41:52PM -0800, Vasily Khoruzhick wrote:
>> Digital part of audio codec block in the A64 is very similar to what
>> is used by the A33(sun8i) devices. However, it uses different LRCK
>> divider.
>>
>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> What makes it impossible to derive from the sample rate and number of
> channels?

It's BCLK / LRCK ratio as per A64 user manual, so it doesn't depend on
sample rate. BSP driver always uses a fixed value of 64 here.

> Have you tried other sampling rates?

I tried speaker-test with a number of sampling rates and had no
issues. I couldn't try it in mono, since sun4i-i2s supports minimum of
2 channels.

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
