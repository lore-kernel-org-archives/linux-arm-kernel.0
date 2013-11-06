From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 6 Nov 2013 08:41:44 -0800
Subject: [PATCH 6/6] arm: zynq: headsmp: Move .glbl out of actual code
In-Reply-To: <5279F3DD.9040605@monstr.eu>
References: <1383235819-2552-1-git-send-email-soren.brinkmann@xilinx.com>
 <1383235819-2552-7-git-send-email-soren.brinkmann@xilinx.com>
 <5279F3DD.9040605@monstr.eu>
Message-ID: <e1194cb0-825b-4cb1-919c-8879aef95d77@VA3EHSMHS008.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 08:46:37AM +0100, Michal Simek wrote:
> On 10/31/2013 05:10 PM, Soren Brinkmann wrote:
> > Move the .glbl lines exporting symbols to the top of the file and out of
> > the actual code, in order to make the code more readable.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  arch/arm/mach-zynq/headsmp.S | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
> > index 57a32869f0aa..12d1b40c7d78 100644
> > --- a/arch/arm/mach-zynq/headsmp.S
> > +++ b/arch/arm/mach-zynq/headsmp.S
> > @@ -9,14 +9,15 @@
> >  #include <linux/linkage.h>
> >  #include <linux/init.h>
> >  
> > +.globl zynq_secondary_trampoline_jump
> > +.globl zynq_secondary_trampoline_end
> > +
> >  ENTRY(zynq_secondary_trampoline)
> >  	ldr	r0, [pc]
> >  	bx	r0
> > -.globl zynq_secondary_trampoline_jump
> >  zynq_secondary_trampoline_jump:
> >  	/* Space for jumping address */
> >  	.word	/* cpu 1 */
> > -.globl zynq_secondary_trampoline_end
> >  zynq_secondary_trampoline_end:
> >  ENDPROC(zynq_secondary_trampoline)
> >  
> 
> I don't want this one.
> I have applied 1-5 to zynq/cleanup branch.
Up to you. But having these .global statements in the middle of actual
code does not help reading the code. And IMHO, they don't belong there.

	S?ren
