From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 21 Feb 2014 09:28:24 -0700
Subject: [PATCH] pcie: Add Xilinx PCIe Host Bridge IP driver
In-Reply-To: <CA+mB=1L+QM2cKq==mwYesp=E7S2N-xTiN7AoBvbzAO2UMn0qVQ@mail.gmail.com>
References: <1392564830-5868-1-git-send-email-sthokal@xilinx.com>
 <CAErSpo5FGPhgnp8Gfy-1_Lk7ckCi7U5+z5pLnPU+jScPxD5yUQ@mail.gmail.com>
 <20140219003523.GJ29304@obsidianresearch.com>
 <CA+mB=1KSxkN+mKce5k1n93pmAA_FnWYaqNweWzxd4GD3Mo4PZA@mail.gmail.com>
 <20140220174503.GB19893@obsidianresearch.com>
 <CA+mB=1L+QM2cKq==mwYesp=E7S2N-xTiN7AoBvbzAO2UMn0qVQ@mail.gmail.com>
Message-ID: <20140221162824.GA4706@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 08:18:00PM +0530, Srikanth Thokala wrote:

> 00:00.0 Class 0604: Device 10ee:7081

So this is great, a root port bridge is exactly correct - I would
recommend using device 1 for this (device 0 is the host bridge in most
cases), but I don't think that has any functional impact.

>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 00000000-00000fff
>         Memory behind bridge: 00000000-000fffff
>         Prefetchable memory behind bridge: 00000000-000fffff

What is going on here?  These ranges should match the MMIO aperture and
critically must enclose the downstream bars:

> 01:00.0 Class 0200: Device 14e4:1677 (rev 11)
>         Region 0: Memory at 60000000 (64-bit, non-prefetchable) [size=64K]
>         Expansion ROM at 60010000 [disabled] [size=64K]

So one of those two is not right..

Jason
