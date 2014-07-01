From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 1 Jul 2014 12:02:54 -0300
Subject: [PATCH 03/16] ARM: mvebu: Add function to export the physical
 address of the boot register
In-Reply-To: <20140701134651.7d34de62@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-4-git-send-email-gregory.clement@free-electrons.com>
 <20140701134651.7d34de62@free-electrons.com>
Message-ID: <20140701150254.GA1986@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01 Jul 01:46 PM, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Fri, 27 Jun 2014 15:22:44 +0200, Gregory CLEMENT wrote:
> 
> >  static void __iomem *system_controller_base;
> > +static u32 system_controller_phys_base;
> >  
> >  struct mvebu_system_controller {
> >  	u32 rstoutn_mask_offset;
> > @@ -109,6 +110,13 @@ void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr)
> >  	writel(virt_to_phys(boot_addr), system_controller_base +
> >  	       mvebu_sc->resume_boot_addr);
> >  }
> > +
> > +u32 mvebu_system_controller_get_phys_addr(void)
> > +{
> > +	BUG_ON(system_controller_phys_base == NULL);
> 
> This rightfully generates a fairly strong warning at compile time:
> you're comparing an u32 to NULL. It should be == 0 here.
> 

Or a more readable BUG_ON(!system_controller_phys_base);
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
