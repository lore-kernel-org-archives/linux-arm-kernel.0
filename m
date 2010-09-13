From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Sep 2010 13:53:10 +0100
Subject: ARM target not boot after remap memory
In-Reply-To: <AANLkTi=dT1uMrRctB4=Hvh35zVc-DtReWmHj-18cd9XT@mail.gmail.com>
References: <AANLkTi=tWwaFHB0DY=j0UaqbYdYJpGJpmWdGC4aMufSw@mail.gmail.com>
	<4C8E1417.4060204@compulab.co.il>
	<20100913124049.GG30787@n2100.arm.linux.org.uk>
	<AANLkTi=dT1uMrRctB4=Hvh35zVc-DtReWmHj-18cd9XT@mail.gmail.com>
Message-ID: <20100913125310.GI30787@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BTW, Please do not drop CCs.

On Mon, Sep 13, 2010 at 02:48:18PM +0200, Robin Theunis wrote:
> Hi Russell,
> 
> Yes I have tested it. I made a breakpoint at 0x2008000 and viewed that
> the r1 register and there in I found the correct ID.
> 
> Robin
> 
> 2010/9/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Mon, Sep 13, 2010 at 02:07:51PM +0200, Mike Rapoport wrote:
> >> (add LAKLM to CC)
> >
> >>> The problem is now when linux kernel is booting, nothing happens.
> >>>
> >>> ---
> >>> U-Boot> bootm
> >>> ## Booting kernel from Legacy Image at 21000000 ...
> >>> ? ?Image Name: ? Linux-2.6.34.1robin9200v1.0
> >>> ? ?Image Type: ? ARM Linux Kernel Image (uncompressed)
> >>> ? ?Data Size: ? ?1811796 Bytes = 1.7 MiB
> >>> ? ?Load Address: 20008000
> >>> ? ?Entry Point: ?20008000
> >>> ? ?Verifying Checksum ... OK
> >>> ? ?Loading Kernel Image ... OK
> >>> OK
> >>>
> >>> Starting kernel ...
> >>>
> >>> Uncompressing Linux... done, booting the kernel.
> >>> ---
> >>>
> >>> Here is stalls. With my jtag probe I can locate the problem.
> >>>
> >>> ---
> >>>> halt
> >>> target state: halted
> >>> target halted in ARM state due to debug-request, current mode: Supervisor
> >>> cpsr: 0x600000d3 pc: 0xc000af3c
> >>> MMU: enabled, D-Cache: enabled, I-Cache: enabled
> >>>> ? arm disassemble 0xc000af3c
> >>> 0xc000af3c ? 0xeafffffe ? ? ?B 0xc000af3c
> >
> > Probably __error. ?Either your machine isn't supported, or the kernel
> > doesn't recognise your processor.
> >
> > Is your version of uboot sufficiently recent that it passes the correct
> > machine ID in r1 ?
> >
