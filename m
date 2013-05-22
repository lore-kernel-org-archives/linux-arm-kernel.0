From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 22 May 2013 17:51:34 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <201305221735.11815.arnd@arndb.de>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de>
Message-ID: <20130522155134.GL2824@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I don't see how this can fix the problem. Which internal register base
> > address do we put in our Device Tree source in arch/arm/boot/dts? The
> > old one? The new one?
> 
> The one matching the boot loader for that board, i.e. the new address
> for all boards but Mirabox and OpenBlocks.

Hi Thomas

Maybe i'm missunderstand Arnd, but i think he is suggesting a property
somewhere in DT which says where the bootloader left the register
space before jumping to the kernel. You can then look at this property
and then decide if you need to remap or not. Only this one property
needs to differ between old and new bootloader. You could even say, if
the property is not in DT, a remap is needed.

However, i don't know if this can actually work. How early can you
parse the DT in order to know where the serial port is for
earlyprintk()? It also gets messy keeping track of the two different
DT binary blobs and somehow having the probe the uboot version in
order to install the right one. I don't know how i would include this
into the debian flash-kernel for example.

I prefer the CP15 bit.

	Andrew
