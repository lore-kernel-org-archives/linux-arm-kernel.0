From: bn@niasdigital.com (Ben Nizette)
Date: Mon, 18 Apr 2011 18:50:12 +1000
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <20110418091902.13345132@lxorguk.ukuu.org.uk>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
Message-ID: <92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 18/04/2011, at 6:19 PM, Alan Cox wrote:

>> gpiolib handles input and output, high and low because that's all that could reasonably be expected to a) always work and b) be changed at run time in the driver.
> 
> Imagine if file systems only handled 8.3 filenames because that's all
> that could reasonably be expected to a) always work !

Fair call, but bringing this back to the particular case in hand what in that enum is worth 'hinting' in a might-have-an-effect manner rather than just letting the board take care of it?

Still my question stands, where is the driver ever better placed to make these calls than the board code?

> 
>> So in short - what's the use case?  Which driver requires this?
>> 
> 
> Also your comment re simply in or out on or off is incorrect. Pins may
> also be in use by firmware and the like and in a 'neither' state.
> Something certain gpio people seem to be in denial over.

Quite right, but should a pin ever be in a neither state and simultaneously controlled by a gpiolib driver?  If so, how should it behave and if not, is it anything that stricter enforcement of gpio_request() semantics can't get around?

	--Ben.

> 
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
