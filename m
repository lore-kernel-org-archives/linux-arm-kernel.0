From: Hollis_Blanchard@mentor.com (Blanchard, Hollis)
Date: Tue, 15 Feb 2011 15:38:25 -0800
Subject: [RFC] Inter-processor Mailboxes Drivers
In-Reply-To: <4D5AF712.3080509@mentor.com>
References: <4D55A7F7.5090700@mentor.com>
	<20110214100104.GC4371@pulham.picochip.com>
	<4D5AF712.3080509@mentor.com>
Message-ID: <DD7A9A95166BF4418C4C1EB2033B6EE2038FAAF0@na3-mail.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2011 01:58 PM, Meador Inge wrote:
> On 02/14/2011 04:01 AM, Jamie Iles wrote:
>> On Fri, Feb 11, 2011 at 03:19:51PM -0600, Meador Inge wrote:
>>>      1. Hardware specific bits somewhere under '.../arch/*'.  Drivers
>>>         for the MPIC message registers on Power and OMAP4 mailboxes, 
>>> for
>>>         example.
>>>      2. A higher level driver under '.../drivers/mailbox/*'.  That the
>>>         pieces in (1) would register with.  This piece would expose the
>>>         main kernel API.
>>>      3. Userspace interfaces for accessing the mailboxes.  A
>>>         '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.
>>
>> How about using virtio for all of this and having the mailbox as a
>> notification/message passing driver for the virtio backend?  There are
>> already virtio console and network drivers that could be useful for the
>> userspace part of it.  drivers/virtio/virtio_ring.c might be a good
>> starting point if you thought there was some mileage in this approach.
>
> To be honest, I am not that familiar with 'virtio', but I will take a 
> look.  Thanks for the pointer.  Maybe Hollis can speak to this idea more.
My opinion is that virtio is (over?) complicated.

I've looked into it in the past, and I'm definitely open to using it if 
somebody can demonstrate how easy it is, but adopting it wouldn't have 
helped OpenMCAPI with our use cases, and would have incurred extra pain, 
so we didn't.

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
