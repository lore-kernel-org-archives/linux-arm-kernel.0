From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 14 Feb 2011 10:01:04 +0000
Subject: [RFC] Inter-processor Mailboxes Drivers
In-Reply-To: <4D55A7F7.5090700@mentor.com>
References: <4D55A7F7.5090700@mentor.com>
Message-ID: <20110214100104.GC4371@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 03:19:51PM -0600, Meador Inge wrote:
>     1. Hardware specific bits somewhere under '.../arch/*'.  Drivers
>        for the MPIC message registers on Power and OMAP4 mailboxes, for
>        example.
>     2. A higher level driver under '.../drivers/mailbox/*'.  That the
>        pieces in (1) would register with.  This piece would expose the
>        main kernel API.
>     3. Userspace interfaces for accessing the mailboxes.  A
>        '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.

How about using virtio for all of this and having the mailbox as a 
notification/message passing driver for the virtio backend?  There are 
already virtio console and network drivers that could be useful for the 
userspace part of it.  drivers/virtio/virtio_ring.c might be a good 
starting point if you thought there was some mileage in this approach.

Jamie
