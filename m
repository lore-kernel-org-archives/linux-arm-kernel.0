From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 23 Aug 2016 20:55:58 +0200 (CEST)
Subject: [Bug] usb: dwc2: host function broken in OTG mode on bcm283x
In-Reply-To: <a058e07d-ac9a-3e70-af7d-059d21875fba@synopsys.com>
References: <907297251.436328.d9cd30e0-7476-4a28-8bab-dde17515cd9c.open-xchange@email.1und1.de>
 <785fc063-9b72-84a9-db91-c2710c19cdf9@synopsys.com>
 <183575717.19886.709cd5b7-97dd-4dda-9392-7c46ec5e192c.open-xchange@email.1und1.de>
 <37db5022-b98c-7f26-ca77-3ee9ba664edf@synopsys.com>
 <1408689388.21552.709cd5b7-97dd-4dda-9392-7c46ec5e192c.open-xchange@email.1und1.de>
 <a058e07d-ac9a-3e70-af7d-059d21875fba@synopsys.com>
Message-ID: <632584624.402351.225ddbfe-fd96-4f9b-a2b9-e0173af882ba.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

> John Youn <John.Youn@synopsys.com> hat am 23. August 2016 um 20:37
> geschrieben:
> 
> 
> 
> How about we fall back to smaller defaults if the original values
> fail? And don't configure more than the amount of endpoints.

this sounds good. I would prefer to calculate the estimated gadget fifo size
before configuring the hardware, so we can bail out without breaking the host
function.

Regards
Stefan

> 
> That should take care of most of the cases. If an irregular
> configuration shows up, require it to use the DT properties.
> 
> Regards,
> John
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
