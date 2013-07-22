From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 22 Jul 2013 14:53:23 -0400 (EDT)
Subject: [PATCH 4/4] ARM: set --be8 when linking modules
In-Reply-To: <51ED69CA.3030501@codethink.co.uk>
References: <1374510833-25716-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374510833-25716-5-git-send-email-ben.dooks@codethink.co.uk>
 <20130722170500.GC19639@codeaurora.org> <51ED69CA.3030501@codethink.co.uk>
Message-ID: <alpine.LFD.2.03.1307221452210.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Ben Dooks wrote:

> On 22/07/13 18:05, Stephen Boyd wrote:
> > On 07/22, Ben Dooks wrote:
> > > To avoid having to make every text section swap the instruction order
> > > of all instructions, make sure modules are built also built with --be8
> > > (as is the current kernel final link).
> > > 
> > > If we do not do this, we would end up having to swap all instructions
> > > when loading a module, instead of just the instructions that we are
> > > applying ELF relocations to.
> > > 
> > 
> > If someone tries to load a be8 module on a non-be8 kernel will it
> > still work? Or should we add an extra version magic string in
> > asm/module.h to prevent that?
> 
> The ELF header changes the EI_DATA field in the ei_ident from
> ELFDATA2LSB to ELFDATA2MSB when compiling so we should be able
> to detect these when loading.
> 
> I have not checked to see if the kernel correctly checks for this.
> 
> I do not think it currently checks the ei_flags field for the
> EF_ARM_BE8 in ABI 4 and 5. I am not sure if this is really important?

If the information is already there and easily accessible, then it 
should be used.


Nicolas
