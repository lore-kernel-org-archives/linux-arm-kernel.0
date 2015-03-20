From: eric@anholt.net (Eric Anholt)
Date: Fri, 20 Mar 2015 10:24:20 -0700
Subject: [PATCH 3/4 v4] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <550BA6B4.3030604@wwwdotorg.org>
References: <1426213936-4139-1-git-send-email-eric@anholt.net>
 <1426213936-4139-3-git-send-email-eric@anholt.net>
 <5507A095.5090805@wwwdotorg.org> <87619xq414.fsf@eliezer.anholt.net>
 <550BA6B4.3030604@wwwdotorg.org>
Message-ID: <87wq2bk2ez.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 03/18/2015 05:28 PM, Eric Anholt wrote:
>> Stephen Warren <swarren@wwwdotorg.org> writes:
>> 
>>> On 03/12/2015 08:32 PM, Eric Anholt wrote:
>>>> diff --git a/drivers/mailbox/bcm2835-mailbox.c
>>>> b/drivers/mailbox/bcm2835-mailbox.c
>>> 
>>>> +#define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) &
>>>> 0xf)) +#define MBOX_CHAN(msg)			((msg) & 0xf) +#define
>>>> MBOX_DATA28(msg)		((msg) & ~0xf)
>>> 
>>> Even the concept of storing channel IDs in the LSBs feels like it
>>> might be RPi-firmware-specific rather than HW-specific?
>> 
>> I guess?  If we found another firmware protocol, we could have
>> that device's dt just specify a different compatible string.  But
>> in the absence of another firmware to talk to, I'm not sure what
>> you want here.
>
> I would expect the mailbox driver to expose a single channel that just
> transports 32-bit values, since the HW doesn't impose any kind of
> structure on the values it transports AFAIK. Clients of the mailbox
> driver would formulate the messages they send through the mailox using
> the macros above.
>
> I'm not sure whether the mailbox core allows multiple clients for the
> same mailbox channel though? This HW appears to require it.

Yeah, that's the problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150320/bb6c83cb/attachment-0001.sig>
