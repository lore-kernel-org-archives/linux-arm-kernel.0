From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 23 May 2013 07:53:06 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522233108.01cb51f0@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <201305222240.05124.arnd@arndb.de> <20130522233108.01cb51f0@skate>
Message-ID: <20130523055306.GV26249@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The new boot loaders will of course know that they are remapping the
> > registers, so they are also able to put the correct information into the
> > DT.
> 
> The thing that I believe you don't realize is that those new bootloaders
> are already shipping *today*. And they are not putting whatever
> "correct" information into the DT you believe they should be putting.
> 
> So what do we do, today, with those new bootloaders, that are not the
> future, but the present. Again, they do *not* add any information in
> the DT that allows us to know that they have remapped the registers to
> 0xf1.

That is a key point. Compared to the kernel, the bootloaders a very
slow to evolve new features, even slower to get deployed, and have a
very long life without ever getting upgraded. The kernel has to deal
with legacy bootloaders.

What we seem to be heading towards is a bootloader which actually uses
the DT itself, can modify it dynamically to reflect the running system,
and pass it to the kernel.

What we have today, on Marvell boards, is mostly no support for DT at
all with blobs appended to the kernel with tools like debians
flash-kernel. Maybe this new Marvell uboot can load the blob in the
same way it can load the kernel, or initrd, from flash, a file on a
disk, tftpboot, etc, but i expect it is just an opaque binary blob to
uboot.

I guess your bootloader which will put the correct information into
the DT is a few years away.

    Andrew
