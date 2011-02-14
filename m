From: iws@ovro.caltech.edu (Ira W. Snyder)
Date: Mon, 14 Feb 2011 08:53:27 -0800
Subject: [RFC] Inter-processor Mailboxes Drivers
In-Reply-To: <AANLkTinu9VMuFgHeFZGXptDYZyJL6P4qxAA9MA8UewpU@mail.gmail.com>
References: <4D55A7F7.5090700@mentor.com>
	<20110214100104.GC4371@pulham.picochip.com>
	<AANLkTinu9VMuFgHeFZGXptDYZyJL6P4qxAA9MA8UewpU@mail.gmail.com>
Message-ID: <20110214165327.GB13271@ovro.caltech.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 12:03:59PM +0200, Ohad Ben-Cohen wrote:
> On Mon, Feb 14, 2011 at 12:01 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> > On Fri, Feb 11, 2011 at 03:19:51PM -0600, Meador Inge wrote:
> >> ? ? 1. Hardware specific bits somewhere under '.../arch/*'. ?Drivers
> >> ? ? ? ?for the MPIC message registers on Power and OMAP4 mailboxes, for
> >> ? ? ? ?example.
> >> ? ? 2. A higher level driver under '.../drivers/mailbox/*'. ?That the
> >> ? ? ? ?pieces in (1) would register with. ?This piece would expose the
> >> ? ? ? ?main kernel API.
> >> ? ? 3. Userspace interfaces for accessing the mailboxes. ?A
> >> ? ? ? ?'/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.
> >
> > How about using virtio for all of this and having the mailbox as a
> > notification/message passing driver for the virtio backend?
> 
> This is exactly what we are doing now, and it looks promising. expect
> patches soon.

I'll be happy to examine the feasibility of doing a port to mpc83xx as
soon as I see the code. :-) I have been using the message registers to
create a software "network card" over PCI (between a host system and an
mpc83xx in a PCI slot). I have wanted to use virtio for this task for a
long time.

I think a uniform interface for the mailbox registers would be a very
useful API.

Thanks,
Ira
