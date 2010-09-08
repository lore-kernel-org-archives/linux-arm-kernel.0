From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Wed, 8 Sep 2010 10:35:58 +0200
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to, from}_user?
In-Reply-To: <alpine.LFD.2.00.1009071443360.19366@xanadu.home>
References: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
	<20100906140347.GA24522@n2100.arm.linux.org.uk>
	<20100906141444.GD6897@debian-wegner1.datadisplay.de>
	<AANLkTimqiAuv9XiU55VBxfPO6HZXCs5d9pshS3XDwsFc@mail.gmail.com>
	<AANLkTi=Mgzw9m+KiyzG7sHqD=mv1Q6WZXqMn_s_+p6Oq@mail.gmail.com>
	<20100907161156.GA3625@debian-wegner1.datadisplay.de>
	<alpine.LFD.2.00.1009071443360.19366@xanadu.home>
Message-ID: <20100908083558.GA3393@debian-wegner1.datadisplay.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 07, 2010 at 03:14:08PM -0400, Nicolas Pitre wrote:
> The STM instruction means store-multiple i.e. it takes a set of 
> registers and write them to memory in one go.  You could try using 
> memset() which should be optimized to use STM in that case:
[...]

Thank you for the explanation and code example!

Using write() (dd if=/dev/zero of=/dev/fb0 bs=1024 count=8192) the 
throughput was slightly lower in either case, but this may as well
be some other overhead (0.035s->0.052s for RAM, 1.299s->1.310s for
PCI frame buffer).

Using your assembler code, I get almost double throughput (0.035s->
0.018s, meaning around 466 MBytes/s) for RAM and a system lockup
for my PCI device. Hmm...

I will now set up some eval boards to see if I get an "off-the-shelf"
framebuffer with a stock PCI graphics card up and running for a
comparison.

Regards,
Wolfgang
