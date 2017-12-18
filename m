From: w@1wt.eu (Willy Tarreau)
Date: Mon, 18 Dec 2017 22:52:17 +0100
Subject: pxa3xx_nand times out in 4.14 with JFFS2
In-Reply-To: <20171218112208.0057634d@xps13>
References: <20171217162342.GA1833@1wt.eu> <20171217190746.2a61232c@bbrezillon>
 <20171217190056.GA1107@1wt.eu>
 <CAAEAJfArtxcWgcjHAb__3BQxWEBgWU8uWtHGYETc-m9eUs91nA@mail.gmail.com>
 <20171217211650.GA6815@1wt.eu> <20171217222611.59f9031b@bbrezillon>
 <20171217224617.1f9b8b84@xps13> <20171218063715.GA20461@1wt.eu>
 <20171218070617.GA16559@1wt.eu> <20171218112208.0057634d@xps13>
Message-ID: <20171218215217.GA17755@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

On Mon, Dec 18, 2017 at 11:22:08AM +0100, Miquel RAYNAL wrote:
> I fixed two problems happening during read/write of 2kiB page NAND
> chips, I am quite confident this would solve the issues you report
> here. Could you please give it a try?

So I just tested right now, and good news, it now works pretty fine
here, and my jffs2 properly mounted (without requiring Boris' fix
for oob) :

# dmesg|grep -i nand
[    0.770395] nand: device found, Manufacturer ID: 0x01, Chip ID: 0xf1
[    0.775474] nand: AMD/Spansion S34ML01G2
[    0.778103] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    0.794080] 10 ofpart partitions found on MTD device pxa3xx_nand-0
[    0.798975] Creating 10 MTD partitions on "pxa3xx_nand-0":
[    3.245034] jffs2: version 2.2. (NAND) (SUMMARY)  \xffffffc2\xffffffa9 2001-2006 Red Hat, Inc.

I was first surprized seeing this "pxa3xx_nand-0" still appearing until I
realized that it's how it's called in the device tree :-)

Cheers,
Willy
