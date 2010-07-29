From: colin.tuckley@arm.com (Colin Tuckley)
Date: Thu, 29 Jul 2010 14:42:39 +0100
Subject: [PATCH 02/12] mmci: fix multi block transfers
In-Reply-To: <20100729133646.GC18923@n2100.arm.linux.org.uk>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-2-git-send-email-rabin.vincent@stericsson.com>
	<20100729131858.GB18923@n2100.arm.linux.org.uk>
	<000001cb2f22$65576150$300623f0$@tuckley@arm.com>
	<20100729133646.GC18923@n2100.arm.linux.org.uk>
Message-ID: <000101cb2f23$e97d1280$bc773780$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]

> No, it doesn't work on Versatile PB926 in mainline (I tried it this
> morning)
> because the card detection (via the ->status callback) is inverted -
> just
> like it was for realview.  What happens is you get commands issued to
> the
> card on card removal, and nothing on card insertion.

Sorry, I wasn't clear - I was talking about the current ARM tree 2.6.33-arm1
where Catalin and I fixed Realview and Versatile so that it worked with
GPIOLIB where the detection was done with GPIO and to revert to the old
method on boards where the detect pins are not available as gpio.

> What I'm proposing is that we get rid of these multiple levels of
> negation
> that we're gaining.  The negations only add additional complexity and
> confusion over what's the right thing to return at any given point.

Ack.

> That means your original patch needs to be reverted, and we need to
> change
> the 'return !status;' to just 'return status;' in mmci.c's get_cd
> function
> as per my patch.

More massaged than reverted I think, but Ack.

> However, I think this will make GPIO on Realview wrong - iirc, the card
> detection bits from PL061 are inverted.

See above.

Colin
