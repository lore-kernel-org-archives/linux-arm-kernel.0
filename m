From: eric@anholt.net (Eric Anholt)
Date: Wed, 18 Mar 2015 16:28:23 -0700
Subject: [PATCH 3/4 v4] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <5507A095.5090805@wwwdotorg.org>
References: <1426213936-4139-1-git-send-email-eric@anholt.net>
 <1426213936-4139-3-git-send-email-eric@anholt.net>
 <5507A095.5090805@wwwdotorg.org>
Message-ID: <87619xq414.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 03/12/2015 08:32 PM, Eric Anholt wrote:
>> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
>
>> +#define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
>> +#define MBOX_CHAN(msg)			((msg) & 0xf)
>> +#define MBOX_DATA28(msg)		((msg) & ~0xf)
>
> Even the concept of storing channel IDs in the LSBs feels like it might
> be RPi-firmware-specific rather than HW-specific?

I guess?  If we found another firmware protocol, we could have that
device's dt just specify a different compatible string.  But in the
absence of another firmware to talk to, I'm not sure what you want here.

Note that Roku's kernel code dump doesn't even communicate through the
mailbox.  vcio.c exists, but is disconnected from the build.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/40d8a5ac/attachment.sig>
