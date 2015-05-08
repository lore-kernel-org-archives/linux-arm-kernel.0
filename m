From: eric@anholt.net (Eric Anholt)
Date: Fri, 08 May 2015 12:19:46 -0700
Subject: [PATCH 2/3 v8] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <2464203.68HkYCAlx7@kongar>
References: <1430857666-18877-1-git-send-email-eric@anholt.net>
 <554BA0B7.8040600@tronnes.org> <87mw1grwnn.fsf@eliezer.anholt.net>
 <2464203.68HkYCAlx7@kongar>
Message-ID: <87a8xenagd.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Stein <alexanders83@web.de> writes:

> On Thursday 07 May 2015, 12:54:20 wrote Eric Anholt:
>> Noralf Tr?nnes <noralf@tronnes.org> writes:
>> 
>> > Den 05.05.2015 22:27, skrev Eric Anholt:
>> >> From: Lubomir Rintel <lkundrak@v3.sk>
>> >>
>> >> This mailbox driver provides a single mailbox channel to write 32-bit
>> >> values to the VPU and get a 32-bit response.  The Raspberry Pi
>> >> firmware uses this mailbox channel to implement firmware calls, while
>> >> Roku 2 (despite being derived from the same firmware tree) doesn't.
>> >>
>> >> The driver was originally submitted by Lubomir, based on the
>> >> out-of-tree 2708 mailbox driver.  Eric Anholt fixed it up for
>> >> upstreaming, with the major functional change being that it now has no
>> >> notion of multiple channels (since that is a firmware-dependent
>> >> concept) and instead the raspberrypi-firmware driver will do that
>> >> bit-twiddling in its own messages.
>> > ...
>> >> +static struct platform_driver bcm2835_mbox_driver = {
>> >> +	.driver = {
>> >> +		.name = "bcm2835-mbox",
>> >> +		.owner = THIS_MODULE,
>> >> +		.of_match_table = bcm2835_mbox_of_match,
>> >> +	},
>> >> +	.probe		= bcm2835_mbox_probe,
>> >> +	.remove		= bcm2835_mbox_remove,
>> >> +};
>> >> +module_platform_driver(bcm2835_mbox_driver);
>> >
>> > I have tested this driver and the firmware driver booting directly
>> > from the VideoCore bootloader (no uboot).
>> > The mailbox driver loads too late to turn on USB power:
>> 
>> Yeah, I have a patch on my branches that returns -EPROBE_DEFER when
>> trying to get a power domain and not finding the provider.  It was
>> rejected by the maintainers in favor of a proposed solution whose
>> description I didn't quite follow.
>
> Do you have a link for this thread?

https://lkml.org/lkml/2015/3/11/483
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150508/4b533b38/attachment.sig>
