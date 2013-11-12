From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 13 Nov 2013 00:12:16 +0100
Subject: arm/arm64 UEFI boot protocol
In-Reply-To: <CACxGe6uCMjNiSm7qN4fTBN=WgzdJriod9d7qKOr-P-UaiWhULQ@mail.gmail.com>
References: <20131111174321.GQ1557@rocoto.smurfnet.nu>
 <20131112164241.GD25953@mudshark.cambridge.arm.com>
 <20131112180050.GR1557@rocoto.smurfnet.nu>
 <CACxGe6uCMjNiSm7qN4fTBN=WgzdJriod9d7qKOr-P-UaiWhULQ@mail.gmail.com>
Message-ID: <20131112231216.GS1557@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 07:14:28AM +0900, Grant Likely wrote:
> In the interest of bike shedding, I would name the properties
> "linux,uefi-mmap-start" and "linux,uefi-mmap-size", but otherwise it
> is fine by me.

That makes sense to me, and makes for a prettier table :)

> Should you have a property for the descriptor version
> as returned by GetMemoryMap()?
 
Yes, I should, really. I did in an earlier version, but dropped it on
realising that this value has not changed since the inception of EFI.
But it needs to be passed back to SetVirtualAddressMap(), so it should
be kept. Mark never dropped it from his.

So, "linux,uefi-mmap-desc-ver"?

/
    Leif
