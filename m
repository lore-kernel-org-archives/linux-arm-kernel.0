From: michal.simek@xilinx.com (Michal Simek)
Date: Sat, 27 Oct 2012 15:20:59 +0000
Subject: [PATCH v4 1/5] zynq: use GIC device tree bindings
In-Reply-To: <20121027144253.GC5190@beefymiracle.amer.corp.natinst.com>
References: <20121024200222.GA6713@beefymiracle.amer.corp.natinst.com>
 <20121024200310.GB6713@beefymiracle.amer.corp.natinst.com>
 <0d1c4cf8-70d8-4d12-bd77-393009d32b22@CH1EHSMHS001.ehs.local>
 <20121027140053.GB5190@beefymiracle.amer.corp.natinst.com>
 <4fd22fac-49c4-4000-9e70-12e94f248753@AM1EHSMHS010.ehs.local>
 <20121027144253.GC5190@beefymiracle.amer.corp.natinst.com>
Message-ID: <60e4cbf9-52b4-4c02-8537-ecd3a7dbbf06@CO1EHSMHS020.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Saturday, October 27, 2012 4:43 PM
> To: Michal Simek
> Cc: arm at kernel.org; Arnd Bergmann; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; John Linn; Nick Bowler
> Subject: Re: [PATCH v4 1/5] zynq: use GIC device tree bindings
> 
> On Sat, Oct 27, 2012 at 02:06:45PM +0000, Michal Simek wrote:
> [...]
> > I am not big fan to use dtsi solution because dts can be simple
> > generated directly From Xilinx design tool based on your hw design.
> > That's why I can't see any benefit To have dtsi file.
> 
> Can I ask you to reconsider? 

I am open to all solution which will help others. I am not definitely saying NO   for this features
I just haven't found a reason to support it.  

> We, for example, don't make any use of the Xilinx
> dev tools to generate our device trees.

Ok. How does your working flow looks like?
I mean you don't get any information from hardware guys how does your hw design look like?

>  Having a dtsi allows for easy extension
> of the zynq-7000 platform for our boards, without having to carry duplicate data.

ok. I think that make sense if you send the next your series as RFC to see how exactly
you would like to use it. 

In my workflow we generate DTS directly from design tool which I expect your hw
guys use because it is probably needed to generate boot.bin/fsbl/etc. 
Then there is one more additional step to setup device-tree bsp to generate DTS
which directly fits to your HW design. 
If you have the same boards with different programmable logic I understand
that you would like to share that PS part and then just add it that IPs in PL.

 
> Is it going to be expected that users building kernels for their zynq targets have
> access to the Xilinx EDK?

Definitely not. You can do it just once and of course you can write it by hand
and then just reusing. 

>From my point of view. You have to use design tools at least once to get bitstream
and boot.bin with fsbl. Please correct me if I am wrong.
In this step you can use device-tree BSP to generate DTS ( I doesn't need to be perfect with 
all attached devices on i2c,spi, phys, etc but it reflects your hardware).
You will get it in some seconds and your dts has correct irq numbers/ip description, compatible strings,
addresses, position in the system - if you use bus bridges, etc) and you can just directly use it
and kernel will boot. If you need to do changes in dts by hand, you can of course do it. 

> > > Would you like for me to pull this into v5, or spin up a separate patch series?
> >
> > Definitely not. I have checked patches but haven't got it work on the zc702.
> > Not sure if you have run it on real hw or just on the qemu as you have
> > mentioned In 5/5.
> 
> You're likely running into the issue Nick has identified in the thread for patch 5
> where the chosen virtual address for the uart doesn't seem to work:
> http://www.spinics.net/lists/arm-kernel/msg203141.html
> 
> We haven't yet identified the root cause; any insight you can provide here
> would be beneficial.
> 
> Otherwise, I'm considering reworking patch 5 to move the uart mapping to a
> known working location.

I just need to get some time to catch you.

thanks,
Michal
