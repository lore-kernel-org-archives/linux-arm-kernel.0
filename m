From: marex@denx.de (Marek Vasut)
Date: Tue, 23 Oct 2012 12:32:37 +0200
Subject: i.MX28 die temperature
In-Reply-To: <81D7F19D-A9F8-4022-81F0-B8A836F7F087@turczak.de>
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com>
 <201210231052.39983.marex@denx.de>
 <81D7F19D-A9F8-4022-81F0-B8A836F7F087@turczak.de>
Message-ID: <201210231232.37469.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Turczak,

> Hi Marek,
> 
> On Oct 23, 2012, at 10:52 AM, Marek Vasut wrote:
> > We have some basic LRADC driver in upstream already, you should use that.
> > 
> > See drivers/staging/iio/adc/mxs-lradc.c
> 
> Thanks for the heads-up.
> I was referring to this driver (pulled from linus' 3.7rc), it does not
> currently seem to have a consumer api for use within other kernel modules.
> Maybe I'm just heading the wrong way now...

Ah yes, it doesn't ... feel free to implement it. It can -- though -- read the 
CPU die temperature, just sample those two channels, substract one from another 
and multiply by the coeficient ... you'll find that in the datasheet.

Best regards,
Marek Vasut
