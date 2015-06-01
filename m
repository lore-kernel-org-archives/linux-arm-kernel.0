From: eric@anholt.net (Eric Anholt)
Date: Mon, 01 Jun 2015 10:57:06 -0700
Subject: [PATCH v6 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1433148509.2361.35.camel@x220>
References: <1432928535-27522-1-git-send-email-eric@anholt.net>
 <1432928535-27522-2-git-send-email-eric@anholt.net>
 <1433148509.2361.35.camel@x220>
Message-ID: <87vbf75n2l.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Bolle <pebolle@tiscali.nl> writes:

> On Fri, 2015-05-29 at 12:42 -0700, Eric Anholt wrote:
>> This gives us a function for making mailbox property channel requests
>> of the firmware, which is most notable in that it will let us get and
>> set clock rates.

>> v6: Drop the try_module_get/module_put stuff, since all clients will
>>     be referencing our symbols in order to call those functions,
>>     anyway.  Fix the kerneldoc comments for the changes in v5.
>
> (This style of commit explanation is getting quite common. I must say I
> rather dislike it. I think people should just update the entire commit
> explanation when needed, and not simply paste any changes at the end of
> it, thereby forcing the the reader to determine which older parts are
> actually overruled by newer parts. Besides, many, or maybe even most, of
> the changes are really not interesting enough to keep in the commit
> explanation.)

It was a slip-up that I didn't move it below the '---'this time (I
changed my workflow a bit, and missed the step).  I was assuming that
Lee would just trim them on pulling in the changes.

>> --- /dev/null
>> +++ b/drivers/firmware/raspberrypi.c
>
>> +EXPORT_SYMBOL_GPL(rpi_firmware_property_list);
>
>> +EXPORT_SYMBOL_GPL(rpi_firmware_property);
>
> A patch that uses these exports hit lkml recently:
> https://lkml.org/lkml/2015/5/28/596 .
>
>> +EXPORT_SYMBOL_GPL(rpi_firmware_get);
>
> But I didn't spot a (recent) patch that uses this export. Is it queued
> somewhere?

This is from the v5 changes due to review feedback, and the clients need
to be changed to use it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150601/419ffcda/attachment.sig>
