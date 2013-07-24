From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 24 Jul 2013 19:41:10 -0400 (EDT)
Subject: [PATCH 14/14] ARM: set --be8 when linking modules
In-Reply-To: <1374661682-9349-15-git-send-email-ben.dooks@codethink.co.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-15-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <alpine.LFD.2.03.1307241930550.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jul 2013, Ben Dooks wrote:

> To avoid having to make every text section swap the instruction order
> of all instructions, make sure modules are built also built with --be8
> (as is the current kernel final link).
> 
> If we do not do this, we would end up having to swap all instructions
> when loading a module, instead of just the instructions that we are
> applying ELF relocations to.

That wouldn't work anyway as you'd also swap constants embedded in the 
instruction stream such as literal pools which are most certainly in BE 
mode already.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Please make sure the kernel will reject modules if they're not compiled 
appropriately.  Either by looking at the ELF record or by altering 
MODULE_ARCH_VERMAGIC.


Nicolas
