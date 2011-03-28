From: jkridner@beagleboard.org (Jason Kridner)
Date: Mon, 28 Mar 2011 08:54:24 -0400
Subject: [RFC PATCH 2/2] OMAP2+: PANDA: Fix up random or missing MAC
	addresses for eth0 and wlan0
In-Reply-To: <alpine.LFD.2.00.1103251615380.11889@xanadu.home>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com>
	<20110324212737.14936.21228.stgit@otae.warmcat.com>
	<78b7faad4cdc37c6b507c008fde18ef3@mail.gmail.com>
	<AANLkTineUsH=Qz83YKJy8YZ1KSE1si-RddQ9eBsPjMdk@mail.gmail.com>
	<alpine.LFD.2.00.1103251615380.11889@xanadu.home>
Message-ID: <AANLkTikgyuZaP=MMSYPpGz98CnJNLteEi_P7HsN-qkO7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2011 at 4:23 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 25 Mar 2011, Jason Kridner wrote:
>
>> I very much like this approach. ?I believed the ability to use the die
>> ID to get a unique code was reasonable approach and that is why I
>> didn't get an EEPROM put onto the BeagleBoard, though Gerald is
>> looking at adding one on a future revision because the lack of one
>> wasn't well received. ?Minor questions below.
>
> If this code had been available and/or the procedure well documented
> before then I believe the reception would have been better.

Understood.  Live and learn and try not to repeat the same mistakes.
Hopefully others pick up on this one.

>
>> The use of the OMAP die id below makes this OMAP specific and the list
>> referenced below of the devices to be referenced makes it Panda
>> specific. ?Is there a way to make the list board specific, but to make
>> these functions that will be used across many OMAP platforms reusable?
>> ?I believe that this current code will result in a lot of
>> cut-and-paste. ?My preference is that this is accepted and that we
>> make this more general when we add this to other OMAP platforms, but
>> it'd be great to capture your suggestions on how to do so before those
>> cut-and-paste patch sets start coming in.
>
> It is true that this might get copied. ?But as I suggested to Andy, it
> is best to wait and see how often this happens before generalizing the
> approach. ?Consolidation is easier when you can see what is actually
> common and what is board specific. ?Otherwise it is easy to
> fall into the over-engineering trap.

Makes sense.  I hope to see this patch accepted for Panda quickly and
we can follow Andy's advice on how to make it more general in the
future as we wee how people use/need it.

>
>
> Nicolas
>
