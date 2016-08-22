From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 22 Aug 2016 22:47:01 +0200 (CEST)
Subject: [Bug] usb: dwc2: host function broken in OTG mode on bcm283x
In-Reply-To: <785fc063-9b72-84a9-db91-c2710c19cdf9@synopsys.com>
References: <907297251.436328.d9cd30e0-7476-4a28-8bab-dde17515cd9c.open-xchange@email.1und1.de>
 <785fc063-9b72-84a9-db91-c2710c19cdf9@synopsys.com>
Message-ID: <183575717.19886.709cd5b7-97dd-4dda-9392-7c46ec5e192c.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

> John Youn <John.Youn@synopsys.com> hat am 22. August 2016 um 22:06
> geschrieben:
> 
> 
> On 8/20/2016 6:03 AM, Stefan Wahren wrote:
> > Hi John,
> > 
> > 
> 
> Hi Stefan,
> 
> Why doesn't DT work? I think all the properties are there to set
> these.

it only works for the future releases, not for existing DT blobs. The DT is part
of the ABI.

Yes, i already send a patch to fix the DT [1], but it would be better to fix the
issue in deep.

> 
> I hesitate to change the legacy/default settings in case it breaks any
> existing drivers that depend on them.

Platforms? I didn't expected that other drivers use these settings.

Another option would be to add the gadget fifo sizes to platform data, but it's
not a nice solution.

Regards
Stefan

[1] -
http://lists.infradead.org/pipermail/linux-rpi-kernel/2016-August/004225.html

> 
> Regards,
> John
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
