From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 30 Jan 2013 14:06:23 -0700
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <CAErSpo4GKimzwTBB8aN4aj7ms=8pfkoV1=j8mstPDCxc-+gPxQ@mail.gmail.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301292254.01069.arnd@arndb.de>
 <20130130042103.GB5734@obsidianresearch.com>
 <201301300955.49473.arnd@arndb.de> <20130130124721.0ad0294e@skate>
 <CAErSpo4GKimzwTBB8aN4aj7ms=8pfkoV1=j8mstPDCxc-+gPxQ@mail.gmail.com>
Message-ID: <20130130210623.GA5241@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 01:48:33PM -0700, Bjorn Helgaas wrote:

> This is a tangent since you're removing the emulated host bridge
> anyway, but it's been mentioned a couple of times, and I'd like to
> understand this.  Jason mentioned earlier in the [07/27] emulated host
> bridge thread that the PCIe spec requires a host bridge at 00:00.0.
> I've never seen that mentioned in the spec; can somebody point me to
> the actual requirement that host bridges appear in config space?

Hum, a more careful search/reading brings up this:

7.2.2.1. Host Bridge Requirements

 [...] The use of Host Bridge PCI class code is reserved for backwards
 compatibility; host Bridge configuration space is opaque to standard
 PCI Express software and may be implemented in an implementation
 specific manner that is compatible with PCI Host Bridge Type 0
 configuration space. A PCI Express Host Bridge is not required to
 signal errors through a Root Complex Event Collector. This support is
 optional for PCI Express Host Bridges.

So, if it is present it is required to be compatible with the 'PCI
Host Bridge' stuff, but it is not mandatory.

My bad, I believe I got also confused with the spec language regarding
a 'host bridge' vs a 'host bridge configuration space'

Regards,
Jason
