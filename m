From: w@1wt.eu (Willy Tarreau)
Date: Mon, 18 Dec 2017 08:06:17 +0100
Subject: pxa3xx_nand times out in 4.14 with JFFS2
In-Reply-To: <20171218063715.GA20461@1wt.eu>
References: <20171217150043.GA1403@1wt.eu>
 <CAAEAJfD47bGTSppEqcRszjAgBUjiCevmdYLKfsQTPYMcVu8VDA@mail.gmail.com>
 <20171217162342.GA1833@1wt.eu> <20171217190746.2a61232c@bbrezillon>
 <20171217190056.GA1107@1wt.eu>
 <CAAEAJfArtxcWgcjHAb__3BQxWEBgWU8uWtHGYETc-m9eUs91nA@mail.gmail.com>
 <20171217211650.GA6815@1wt.eu> <20171217222611.59f9031b@bbrezillon>
 <20171217224617.1f9b8b84@xps13> <20171218063715.GA20461@1wt.eu>
Message-ID: <20171218070617.GA16559@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 07:37:15AM +0100, Willy Tarreau wrote:
> > As Boris said, we would really welcome a test of this branch, because
> > you almost have the same setup as Sean in the thread "pxa3xx: wait time
> > out when scanning for bb" and I am running out of explanation for his
> > problem unless it is related to U-Boot. So if you could try booting
> > with and without the on-flash-bbt property and report whether it fails
> > or not it would be of great help!
> 
> Yes, I noticed your work mentionned in some of the threads I've read
> during my troubleshooting session and considered giving it a try. I'll
> probably do this next week-end.

Finally I figured the test was quick enough and could help you, so I
built and booted it, I'm getting this at boot :

marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error while writing BBT block -110
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error -110 while marking block 1023 bad
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error while writing BBT block -110
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error -110 while marking block 1022 bad
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error while writing BBT block -110
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error -110 while marking block 1021 bad
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error while writing BBT block -110
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error -110 while marking block 1020 bad
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error while writing BBT block -110
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error -110 while marking block 1019 bad
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error while writing BBT block -110
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error -110 while marking block 1018 bad
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error while writing BBT block -110
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error -110 while marking block 1017 bad
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error while writing BBT block -110
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
marvell-nfc f10d0000.nand-controller: Timeout waiting for RB signal
nand_bbt: error -110 while marking block 1016 bad
No space left to write bad block table
nand_bbt: error while writing bad block table -28
marvell-nfc f10d0000.nand-controller: nand_scan_tail failed: -28
marvell-nfc: probe of f10d0000.nand-controller failed with error -28

Then no MTD appears in /proc/mtd.

Hoping this helps,
Willy
