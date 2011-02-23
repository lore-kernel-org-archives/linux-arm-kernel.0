From: davidb@codeaurora.org (David Brown)
Date: Tue, 22 Feb 2011 19:05:58 -0800
Subject: [PATCH] msm: add single-wire serial bus interface (SSBI) driver
In-Reply-To: <alpine.LFD.2.00.1102222049410.22028@xanadu.home> (Nicolas
	Pitre's message of "Tue, 22 Feb 2011 21:37:28 -0500 (EST)")
References: <1297989299-27320-1-git-send-email-kheitke@codeaurora.org>
	<1297989432.9680.50.camel@c-dwalke-linux.qualcomm.com>
	<4D5DC289.1090004@codeaurora.org>
	<1298054771.17758.1.camel@c-dwalke-linux.qualcomm.com>
	<AANLkTi=0Pxg09x8DdVDVy9Ur7r1dgB+4LM3q0hM4_8Rg@mail.gmail.com>
	<1298419839.17118.5.camel@m0nster> <8ya62sbli3z.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1102222049410.22028@xanadu.home>
Message-ID: <8ya8vx7jvqh.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22 2011, Nicolas Pitre wrote:

> And if someone else comes up with a SSBI interface, then it will be much 
> easier to notice the already existing driver if it is in the driver 
> directory rather than somewhere else in some unrelated (from that 
> person's pov) obscure directory.

Well, I'm fairly sure that nobody would be making an SSBI interface, but
point taken.

>> It seems kind of unusual to create an entirely new directory under
>> drivers to hold what will only ever be a single driver.
>
> Well, a couple examples exist already: drivers/dca, drivers/nfc, 
> drivers/sn, drivers/tc, drivers/vlynq, etc.  And if you expect to have 
> more oddball msm drivers then you can create a drivers/msm directory, 
> similar to the existing drivers/macintosh, drivers/parisc, drivers/s390, 
> drivers/sh, drivers/video/omap, drivers/video/omap2, etc.

drivers/msm seems like a reasonable place.  We already have other
drivers that are in appropriate places.

So what kinds of things constitute drivers versus arch-specific code?
Currently, iommu drivers seem to be sprinkled throughout arch.

We also have a shared-memory driver-type thing that is only used by
other drivers.  Does that make sense to be in drivers/msm?

Ken, do you mind moving this driver into 'drivers/msm' as the first one
there?

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
