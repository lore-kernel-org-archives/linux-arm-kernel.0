From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 26 Feb 2018 18:28:43 +0800
Subject: [PATCH 01/15] clk: sunxi-ng: Add check for minimal rate to NM PLLs
In-Reply-To: <20180226102557.7bgjs3txp7cbridn@flea.lan>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <20180224214545.3740-2-jernej.skrabec@siol.net>
 <20180226093800.uwbo54wrdcwmsyzh@flea.lan>
 <CAGb2v64fxs5Ne5=orQxNcg70Z_N0NJyyC7MPuNH6pxcqrsUq4g@mail.gmail.com>
 <20180226102557.7bgjs3txp7cbridn@flea.lan>
Message-ID: <CAGb2v67X8BpvSbxj4So0fdPnY5c6yEKza6b=KZWf7qxMaOUXWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 6:25 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Mon, Feb 26, 2018 at 05:43:01PM +0800, Chen-Yu Tsai wrote:
>> On Mon, Feb 26, 2018 at 5:38 PM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>> > Hi,
>> >
>> > On Sat, Feb 24, 2018 at 10:45:31PM +0100, Jernej Skrabec wrote:
>> >> Some NM PLLs doesn't work well when their output clock rate is set below
>> >> certain rate.
>> >>
>> >> Add support for that constrain.
>> >
>> > In such a case, you should round the rate to the minimum the clock can
>> > operate at, and not return an error.
>>
>> That's true for round_rate. But what's the expected behavior of set_rate?
>> AFAIK we presume all users call round_rate before set_rate, but that doesn't
>> seem to be true all the time.
>
> One of the first things that happens during a set_rate is a round_rate:
> https://elixir.bootlin.com/linux/v4.16-rc3/source/drivers/clk/clk.c#L1873

Ah! This was added recently in commit ca5e089a32c5 ("clk: use round rate
to bail out early in set_rate").

Thanks for the tip!
ChenYu
