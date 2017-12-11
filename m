From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 11 Dec 2017 09:18:55 +0100
Subject: [PATCH 2/8] iio: adc: axp20x_adc: add support for AXP813 ADC
In-Reply-To: <20171210163655.43fbd3c0@archlinux>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <ef830ce470a4f0f4be6040a776b6928bf89c0143.1512396054.git-series.quentin.schulz@free-electrons.com>
 <20171210163655.43fbd3c0@archlinux>
Message-ID: <b2cdd796-5c22-c114-bc74-41b900a05464@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On 10/12/2017 17:36, Jonathan Cameron wrote:
> On Mon,  4 Dec 2017 15:12:48 +0100
> Quentin Schulz <quentin.schulz@free-electrons.com> wrote:
> 
>> The X-Powers AXP813 PMIC is really close to what is already done for
>> AXP20X/AXP22X.
>>
>> There are two pairs of bits to set the rate (one for Voltage and Current
>> measurements and one for TS/GPIO0 voltage measurements) instead of one.
> 
> This would normally imply we need to split the device into two logical
> IIO devices.  However, that only becomes relevant if we are using
> buffered output which this driver doesn't support.
> > It'll be nasty to deal with this if we add that support down the line
> though.  Up to you though as it's more likely to be your problem than
> anyone else's :)
> 

I have no plans for supporting buffered output for the AXPs at the
moment. But that's an interesting (and important) limitation to raise.
Wouldn't be more of a hack to have two IIO devices representing the
actual same IP?

> For now you could elect to support the different sampling frequencies
> if you wanted to but just providing controls for each channel.
> 

I guess that you're offering to use IIO_CHAN_INFO_SAMP_FREQ in
info_mask_separate for each channel?

> Given the driver doesn't currently expose these at all (I think)
> this is all rather immaterial ;)

I'm not giving the user the option to chose the sampling frequency for
now. I have no plans to do it either, but I think it would be rather
simple to later add support for setting frequency sampling since we only
need to add a sysfs entry (with IIO_CHAN_INFO_SAMP_FREQ) that does not
exist yet. Don't you think? Am I missing something?

Thanks,
Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
