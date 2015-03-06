From: robherring2@gmail.com (Rob Herring)
Date: Thu, 5 Mar 2015 21:02:03 -0600
Subject: [PATCH v2 1/7] ARM: at91: switch to multiplatform
In-Reply-To: <20150305233532.GD3989@piout.net>
References: <1425583068-5826-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425583068-5826-2-git-send-email-alexandre.belloni@free-electrons.com>
 <CAL_Jsq+r3KrAcR+n6uwo-k_OVNfzDrK+MNZ7ech_RsQirutaaQ@mail.gmail.com>
 <20150305233532.GD3989@piout.net>
Message-ID: <CAL_JsqKm9iaqQqs_RsdYa=ePW8akcLFMVis8oHLWU0zOEfVkwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 5, 2015 at 5:35 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 05/03/2015 at 16:50:57 -0600, Rob Herring wrote :
>> > -config SOC_SAMA5
>> > +config ARCH_AT91
>> >         bool
>> > -       select ATMEL_AIC5_IRQ
>> > +       select ARCH_REQUIRE_GPIOLIB
>> >         select COMMON_CLK_AT91
>> > -       select CPU_V7
>> > +       select CLKDEV_LOOKUP
>>
>> This is already selected by COMMON_CLK I think.
>>
>> >         select GENERIC_CLOCKEVENTS
>>
>> This is already selected.
>>
>
> I'm just moving options around I didn't add or remove any. That applies
> to most of your comments.

You are enabling multiplatform which means you can drop selecting the
ones multiplatform selects. I've cleaned-up up the tree once for this
and I don't care to do it again.

Rob
