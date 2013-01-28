From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 28 Jan 2013 23:18:29 +0100
Subject: [PATCH v2 07/27] PCI: Add software-emulated host bridge
In-Reply-To: <20130128220904.GA21446@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301282018.17714.arnd@arndb.de> <5106F5CB.8050304@wwwdotorg.org>
 <20130128220904.GA21446@obsidianresearch.com>
Message-ID: <20130128231829.6b205c3c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Mon, 28 Jan 2013 15:09:04 -0700, Jason Gunthorpe wrote:

> If Linux will discover properly (I strongly suspect it does) without
> the host bridge, then I would say to ditch this...
> 
> The PCI-E standard requires a host bridge device, but if Linux doesn't
> require it then there is no reason to emulate one.
> 
> That would simplify the question of PCI IDs - for Marvell's case and
> the sw root port bridge we can just copy the IDs from the bogus config
> space of the HW.

Not sure what you mean in this last paragraph. In this second version,
I really rely on the emulated PCI-to-PCI bridges for the resource
allocation. I give the Linux PCI core a global range of addresses for
memory regions and a global range of addresses for I/O regions, and
then I let Linux do the allocation of ranges on a per bridge basis,
depending on the devices detected downstream. And at the end, I use
those allocated ranges to set up the address decoding windows.

This all comes from your suggestions during the review of the first
revision of this patch set.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
