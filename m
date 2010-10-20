From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 20 Oct 2010 21:53:02 +0200
Subject: [patch 1/9] efikamx: read board id
In-Reply-To: <20101020192641.GA6466@bee.dooz.org> (=?utf-8?Q?=22Lo=C3=AFc?=
	Minier"'s message of "Wed\, 20 Oct 2010 21\:26\:41 +0200")
References: <20101019204253.162641893@rtp-net.org>
	<20101019205251.082848683@rtp-net.org>
	<20101019211507.GA28242@pengutronix.de>
	<AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
	<20101020091654.GL28166@pengutronix.de>
	<AANLkTimoLQKUjrTHv9xwd8TkGQ3inT_+4-hjfo+Tudj=@mail.gmail.com>
	<20101020192641.GA6466@bee.dooz.org>
Message-ID: <8739s0iqu9.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lo?c Minier <loic.minier@linaro.org> writes:

> On Wed, Oct 20, 2010, Matt Sealey wrote:
>> Uwe, there is no way to tell if the pads have settled, it is entirely
>> a hardware problem, just like when GPIOs are at random input states if
>> they are not connected to anything: in this case, first of all the
>> IOMUX pull downs and then the GPIO change to input takes longer than
>> you can safely do it and then immediately read the pins or board
>> version 1.1 and below will not ID correctly.
>
>  Is there a strong need to distinguish between all the PCB ids?  You
>  could use the TO2 versus TO3 information to decide between 1.1 and 1.3
>  PCBs and stop supporting the other (rare) boards?

The TO2 and TO3 are very similar but there are important differencies :
- different reset pin
- mmc slot on mmc0 (esdhci1) vs mmc1 (esdhci2)

So you do need to know if you're either on TO2 or TO3 and you can't
guess this info without looking at the board id pins.

Arnaud
