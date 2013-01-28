From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 28 Jan 2013 15:51:05 -0700
Subject: [PATCH v2 07/27] PCI: Add software-emulated host bridge
In-Reply-To: <20130128233048.2ab6a6d2@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301282018.17714.arnd@arndb.de> <5106F5CB.8050304@wwwdotorg.org>
 <20130128220904.GA21446@obsidianresearch.com>
 <20130128231829.6b205c3c@skate>
 <20130128222348.GA21628@obsidianresearch.com>
 <20130128233048.2ab6a6d2@skate>
Message-ID: <20130128225105.GA21935@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 11:30:48PM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Mon, 28 Jan 2013 15:23:48 -0700, Jason Gunthorpe wrote:
> 
> > I'm refering to your earlier question about what PCI IDs to use for
> > the SW emulated devices. If there is no need for the host bridge then
> > you only need 1 PCI ID (for the root port bridge) and you can probably
> > fairly safely re-use the one in the Marvell config space of the HW.
> 
> Ah, ok, I see. But isn't a host bridge needed to bind all the
> PCI-to-PCI bridges under a single bus, in order to get the global
> resource assignment I was referring to?

The PCI-E spec requires it, but AFAIK it doesn't actually *do*
anything on Linux, and Linux doesn't require it.

I thought Thierry did this experiment and decided it wasn't necessary:

> The reason is that with the latest bindings the matching of root
> ports to device tree nodes works as-is and nothing else indicates
> that the emulated host bridge is actually required to make any of
> this work. So in order not to introduce unneeded code I've left it
> out for now. If somebody decides that we actually need this host
> bridge (for standards compliance or whatnot) it could easily be
> added back.

Jason
