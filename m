From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Fri, 13 Nov 2009 12:21:43 +0100
Subject: PCI hotplug supported on ARM (Kirkwood)? - fakephp?
In-Reply-To: <cl2us6-035.ln1@chipmunk.wormnet.eu>
References: <200911121826.06792.dk-arm-linux@gmx.de>
	<cl2us6-035.ln1@chipmunk.wormnet.eu>
Message-ID: <200911131221.43527.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag 12 November 2009 20:01:32 schrieb Alexander Clouter:

> Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> > 
> > is it possible to boot a FPGA which is connected to an PCI bus on a 
> > kirkwood cpu (via a pcie->pci bridge) at runtime (I call it hotplug)?
> > 
> > And after booting the FPGA e.g. via slave serial protocol loading the 
> > pci driver and access the device? This would be much easier to handle 
> > than flashing the fpga using u-boot.
> > 
> > Is there any special framework I have to use? How can I tell the 
> > kernel to reenumerate the bus and reasign the pci resources?
> > 
> > I have googled a lot and also tried to find something at newsgroups or 
> > mailinglists but I haven't found some valuable information - at least 
> > not for me ;). Is this possible?
> > 
> I tried tackling this on my board by creating a new 'bus' and trying to 
> work around making the FPGA 'hotplugable' that way.  As the bus would 
> know about the process of reprogramming the FPGA, it could cleanly 
> unload and reload everything.
> 
> http://marc.info/?l=linux-kernel&m=124441477117607&w=2
> 
> Never did get it to work and no one expressed any real interest in it 
> for the platform sadly; so I drifted off looking for other geeky things 
> to do.
> 
> I am still personally keener on the bus model, but Geert suggested I 
> lump for a MFD.

Hm, it looks like fakephp is what I was looking for but I see no way to compile
this module on my arm (kirkwood).

Does anybody know a way to compile it?

Many thanks,
Dieter



> 
> Whatever you do, if you can keep me in the loop then I can nick your 
> ideas/code and maybe get back into tinkering with my ARM board, that's 
> if I stop bricking my MIPS boards :-/
> 
> Cheers
> 
