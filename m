From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 10 Sep 2013 16:05:49 +0100
Subject: [GIT PULL 0/3] ARM: SoC: Second round of changes for v3.12
In-Reply-To: <CA+55aFxNbH+G6DVQNxE9di_btA5hxFH93af_vjN2v0eH8e5W-g@mail.gmail.com>
References: <1378766555-9679-1-git-send-email-khilman@linaro.org>
 <CA+55aFxNbH+G6DVQNxE9di_btA5hxFH93af_vjN2v0eH8e5W-g@mail.gmail.com>
Message-ID: <1378825549.2627.316.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-09-09 at 16:49 -0700, Linus Torvalds wrote:
> 
> Ok. I still really despise the absolute incredible sh*t that is
> non-discoverable buses, and I hope that ARM SoC hardware designers all
> die in some incredibly painful accident.  DT only does so much.

Setting aside the inevitable whining from the emotionally-incontinent
contingent that the above way of saying it will provoke, I'm not quite
sure why you still haven't got over the fact that we have
non-discoverable buses.

In cost-sensitive products (and what *isn't* cost-sensitive these days),
you really don't want to have to put an extra EEPROM on the board
somewhere, just to describe what devices you've hung off which
chip-select today. Storing that in the main flash is just *going* to
happen, however much we'd like to think that devices should identify
themselves cleanly and autonomously.

And it isn't even something that a simple number like a PCI ID could
manage. Peripherals are synthesisable components which vary *wildly*,
with what are essentially #ifdefs in the VHDL. So a given controller
could be seen with different FIFO depths, different numbers of queues,
all kinds of variations. To cover the various permutations, you'd have
to assign an *insane* number of PCI IDs. And then there's the various
ways that you can connect blocks *together*...

That's why we end up with the device-tree model which gives us a rich
way to describe *this* instance of the hardware. If it wasn't
device-tree, it'd have to be something *else*.

>From a software point of view it *isn't* nice, I agree. But you might as
well be railing against the sunset, as far as I can tell.

Not that any of this excuses crappy merges with lots of conflicts; but
those don't seem to be an inexorable result of non-discoverable buses.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130910/dbeab541/attachment-0001.bin>
