From: neko@genesi-usa.com (Matt Sealey)
Date: Wed, 20 Oct 2010 15:53:37 -0500
Subject: [patch 1/9] efikamx: read board id
In-Reply-To: <20101020192641.GA6466@bee.dooz.org>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205251.082848683@rtp-net.org>
	<20101019211507.GA28242@pengutronix.de>
	<AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
	<20101020091654.GL28166@pengutronix.de>
	<AANLkTimoLQKUjrTHv9xwd8TkGQ3inT_+4-hjfo+Tudj=@mail.gmail.com>
	<20101020192641.GA6466@bee.dooz.org>
Message-ID: <9CFE3AB3-2EF2-4F00-9E63-AF724BEED0A1@genesi-usa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No like I said several boards will work with the code as the pcb design has changed. I am sure the few people with 1.0 boards would like to run 2.6.36 too.

It's just about decoupling the setting of the pins and reporting the board id. Set the board id pins up first. Then do some other stuff. Then go back before you need it, and set system_rev up.

Matt Sealey
Product Development Analyst
Genesi USA, Inc.

On Oct 20, 2010, at 2:26 PM, Lo?c Minier <loic.minier@linaro.org> wrote:

> On Wed, Oct 20, 2010, Matt Sealey wrote:
>> Uwe, there is no way to tell if the pads have settled, it is entirely
>> a hardware problem, just like when GPIOs are at random input states if
>> they are not connected to anything: in this case, first of all the
>> IOMUX pull downs and then the GPIO change to input takes longer than
>> you can safely do it and then immediately read the pins or board
>> version 1.1 and below will not ID correctly.
> 
> Is there a strong need to distinguish between all the PCB ids?  You
> could use the TO2 versus TO3 information to decide between 1.1 and 1.3
> PCBs and stop supporting the other (rare) boards?
> 
> -- 
> Lo?c Minier
