From: leon.woestenberg@gmail.com (Leon Woestenberg)
Date: Mon, 13 Sep 2010 19:10:59 +0200
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to, from}_user?
In-Reply-To: <20100909162135.GA3524@debian-wegner1.datadisplay.de>
References: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
	<20100906140347.GA24522@n2100.arm.linux.org.uk>
	<20100906141444.GD6897@debian-wegner1.datadisplay.de>
	<AANLkTimqiAuv9XiU55VBxfPO6HZXCs5d9pshS3XDwsFc@mail.gmail.com>
	<AANLkTi=Mgzw9m+KiyzG7sHqD=mv1Q6WZXqMn_s_+p6Oq@mail.gmail.com>
	<20100907161156.GA3625@debian-wegner1.datadisplay.de>
	<alpine.LFD.2.00.1009071443360.19366@xanadu.home>
	<20100908083558.GA3393@debian-wegner1.datadisplay.de>
	<20100909162135.GA3524@debian-wegner1.datadisplay.de>
Message-ID: <AANLkTimAStrSQQZqX4Dsczas+z02-OnDB4RzO0MxbQhN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfgang,

On Thu, Sep 9, 2010 at 6:21 PM, Wolfgang Wegner <ww-ml@gmx.de> wrote:
> On Wed, Sep 08, 2010 at 10:35:58AM +0200, Wolfgang Wegner wrote:
>>
> With the FPGA evaluation board I get:
> - around 38 MBytes/second with Nicolas' inline assembly code
> - around 6 MBytes/second with any other C code (mmapped) as
> ?well as write() via dd
>
> So the main problem seems to be either our board implementation
> of the PCIe->PCI bridge or the FPGA. However, I am still wondering
> how a framebuffer-based application can attain reasonable performance,
>
Having implemented a framebuffer demo on an FPGA recently using PCI
Express, I think the main performance gain is made by having the DMA
done by the endpoint (FPGA) rather than by the CPU.

> PS: another PCI device I tried via the PCIe->PCI bridge was
> ? ?a Intel 82574L GBit NIC, which was able to reach >600MBit/s
> ? ?throughput when tested with netio or netperf
>
Such devices (typically) use endpoint initiated DMA, i.e. they do not
involve much overhead/latencies on the CPU/host/root complex side.

Regards,

Leon.
