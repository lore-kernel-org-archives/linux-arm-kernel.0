From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 17:02:42 -0300
Subject: [PATCH v3 05/12] ARM: mvebu: Remove the harcoded BootROM window
 allocation
In-Reply-To: <20130618195111.GC6578@obsidianresearch.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618173906.GC2204@obsidianresearch.com>
 <20130618194330.GA2394@localhost>
 <20130618195111.GC6578@obsidianresearch.com>
Message-ID: <20130618200240.GB2470@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 01:51:11PM -0600, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2013 at 04:43:31PM -0300, Ezequiel Garcia wrote:
> 
> > > I think some kind of test is needed here. As I understand it the SMP
> > > startup uses a trampoline in the boot rom and the boot rom *must* be
> > > mapped to 0xfff00000 ?
> 
> > Yes, that's my understanding as well, but I will do some testing since
> > it should be interesting...
> 
> If it is like the earlier chips you will also have the choice of
> something based at 0, there is a register bit that sets the reset
> address.
>  
> > > Verifying the DT is setup this way and aborting if it is not seems
> > > like a good idea..
> 
> > I have no problem doing that, but to me it sounds as it's the
> > responsability of the one that writes the DT, no?
> 
> Having the kernel enforce that the DT node is present and at the right
> location, I think, is helpful for the bootloader folks to ensure they
> write correct DTs.
>

Granted. But then I wonder... why do we bother to put the BootROM in the
DT window if we're going to check for a fixed address it in any case?

> > Maybe this is a requirement for this SoC, but not for another...
> > so, why should the kernel *check* for that?
> 
> The function was called armada_xp_smp_prepare_cpus - all Armada XP's
> will work like this..
> 

Right. Silly objection.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
