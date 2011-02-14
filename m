From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 14 Feb 2011 12:03:59 +0200
Subject: [RFC] Inter-processor Mailboxes Drivers
In-Reply-To: <20110214100104.GC4371@pulham.picochip.com>
References: <4D55A7F7.5090700@mentor.com>
	<20110214100104.GC4371@pulham.picochip.com>
Message-ID: <AANLkTinu9VMuFgHeFZGXptDYZyJL6P4qxAA9MA8UewpU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 12:01 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> On Fri, Feb 11, 2011 at 03:19:51PM -0600, Meador Inge wrote:
>> ? ? 1. Hardware specific bits somewhere under '.../arch/*'. ?Drivers
>> ? ? ? ?for the MPIC message registers on Power and OMAP4 mailboxes, for
>> ? ? ? ?example.
>> ? ? 2. A higher level driver under '.../drivers/mailbox/*'. ?That the
>> ? ? ? ?pieces in (1) would register with. ?This piece would expose the
>> ? ? ? ?main kernel API.
>> ? ? 3. Userspace interfaces for accessing the mailboxes. ?A
>> ? ? ? ?'/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.
>
> How about using virtio for all of this and having the mailbox as a
> notification/message passing driver for the virtio backend?

This is exactly what we are doing now, and it looks promising. expect
patches soon.
