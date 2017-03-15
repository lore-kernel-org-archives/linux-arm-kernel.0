From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 15 Mar 2017 16:19:41 +0000
Subject: Enumerating an empty bus hangs the entire system
In-Reply-To: <135a0b18-caa3-d3c2-8ea5-6959e70e75ac@free.fr>
References: <1eeea8ff-0840-a005-38b4-61f3c253cee1@free.fr>
 <20170315160238.GB5073@bhelgaas-glaptop.roam.corp.google.com>
 <135a0b18-caa3-d3c2-8ea5-6959e70e75ac@free.fr>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFB1ABE@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mason
> Sent: 15 March 2017 16:14
> On 15/03/2017 17:02, Bjorn Helgaas wrote:
> 
> > If checking for link in your accessor is the best you can do, maybe
> > that's all you can do.  I thought there was another driver that did
> > that, but I can't find it now.  It doesn't seem perfectly safe to me,
> > since the link could go down after you check for "link up" and before
> > you actually issue the read.
> 
> Are you thinking of some hotplug scenario?
> 
> My system doesn't support hotplug, and I naively thought that the
> link would be down if there is no card, and up shortly after reset
> if there is a card.

Noise on the lines can be enough to take the link down.

We have some very annoying Dell x86 server chassis that generate an
NMI when the PCIe link has any sort of error.
The software can be 'hardened' to reads returning ~0u, doing anything
useful in an NMI handler is almost impossible.
They also won't boot is there is an error early on.
Stops us doing a remove, reprogram fpga, rescan.

	David
