From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 15 Aug 2011 17:53:45 +0800
Subject: [PATCH v2 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
	SSP/SPI) driver
In-Reply-To: <1313401784.93192.YahooMailClassic@web29015.mail.ird.yahoo.com>
References: <CAMPhdO8WOsnbCvqGGYqnCMiw71esp-OqXryXAS4Xeb0id2DG2g@mail.gmail.com>
	<1313401784.93192.YahooMailClassic@web29015.mail.ird.yahoo.com>
Message-ID: <CAMPhdO-8QNDKVjLArWVoSUXHHCOgCFMrhbxAyXwvUzvWF4dS+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 5:49 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> --- On Mon, 15/8/11, Eric Miao <eric.y.miao@gmail.com> wrote:
>> > MFP_CFG_OUT(GPIO102, ...) had already moved from the
>> patch v1 platform file to patch v2 mfp-pxa27x.h because it
>> was suggested that MFP macros should not be used directly.
>> > Changing the direction in the platform file would
>> surely require using the MFP macros again, so how to keep
>> everyone happy? Maybe I should just define a more generic
>> name such as GPIO102_GPIO_OUT?
>>
>> I guess we need a new definition for this config, looks
>> like SCLK here
>> is different from a normal configuration because the pxa27x
>> is used
>> as a SPI slave here?
>>
>> And checked a bit with the pxa27x developer manual, there
>> is no SCLK
>> for this GPIO102????
>
> GPIO102 is apparently a navpoint power enable; the old linux-2.6.21-hh20 kernel from handhelds.org defines it thus:
>
> #define GPIO_NR_HX4700_SYNAPTICS_POWER_ON ? ? ? ?102
>
> I verified that it does need to be asserted before the navpoint will work. I don't possess any hx4700 developer documentation; perhaps Philipp can shed some light on GPIO102.
>

Ah, that case it's simply a GPIO then. You could simply use GPIO102_GPIO
to configure the pin. And direction is controlled by gpio_direction_*().
