From: Hollis_Blanchard@mentor.com (Blanchard, Hollis)
Date: Wed, 16 Feb 2011 12:22:41 -0800
Subject: [openmcapi-dev] Re: [RFC] Inter-processor Mailboxes Drivers
In-Reply-To: <20110216.082228.814509512977216497.Hiroshi.DOYU@nokia.com>
References: <20110214100104.GC4371@pulham.picochip.com>	<4D5AF712.3080509@mentor.com>	<DD7A9A95166BF4418C4C1EB2033B6EE2038FAAF0@na3-mail.mgc.mentorg.com>
	<20110216.082228.814509512977216497.Hiroshi.DOYU@nokia.com>
Message-ID: <DD7A9A95166BF4418C4C1EB2033B6EE2038FAB15@na3-mail.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2011 10:22 PM, Hiroshi DOYU wrote:
> From: "ext Blanchard, Hollis"<Hollis_Blanchard@mentor.com>
> Subject: Re: [RFC] Inter-processor Mailboxes Drivers
> Date: Tue, 15 Feb 2011 15:38:25 -0800
>
>> On 02/15/2011 01:58 PM, Meador Inge wrote:
>>> On 02/14/2011 04:01 AM, Jamie Iles wrote:
>>>> On Fri, Feb 11, 2011 at 03:19:51PM -0600, Meador Inge wrote:
>>>>>       1. Hardware specific bits somewhere under '.../arch/*'.  Drivers
>>>>>          for the MPIC message registers on Power and OMAP4 mailboxes,
>>>>> for
>>>>>          example.
>>>>>       2. A higher level driver under '.../drivers/mailbox/*'.  That the
>>>>>          pieces in (1) would register with.  This piece would expose the
>>>>>          main kernel API.
>>>>>       3. Userspace interfaces for accessing the mailboxes.  A
>>>>>          '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.
>>>> How about using virtio for all of this and having the mailbox as a
>>>> notification/message passing driver for the virtio backend?  There are
>>>> already virtio console and network drivers that could be useful for the
>>>> userspace part of it.  drivers/virtio/virtio_ring.c might be a good
>>>> starting point if you thought there was some mileage in this approach.
>>> To be honest, I am not that familiar with 'virtio', but I will take a
>>> look.  Thanks for the pointer.  Maybe Hollis can speak to this idea more.
>> My opinion is that virtio is (over?) complicated.
> Considering the case of omap mailbox H/W, it is just a simple one way
> 4 slot x 32bit H/W FIFO, I also may think that this may be a bit too
> much...
I think the proposal is to implement a virtio link using the OMAP 
mailboxes as the interrupt mechanism, and shared memory to carry the 
data and descriptor rings.

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
