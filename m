From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 6 Mar 2014 16:04:42 +0000
Subject: [PATCH v5 1/7] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <201403042330.09607.arnd@arndb.de>
References: <1393948204-11555-1-git-send-email-Liviu.Dudau@arm.com>
 <1393948204-11555-2-git-send-email-Liviu.Dudau@arm.com>
 <201403042330.09607.arnd@arndb.de>
Message-ID: <20140306160442.GG6457@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 10:30:09PM +0000, Arnd Bergmann wrote:
> On Tuesday 04 March 2014, Liviu Dudau wrote:
> > +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> > +{
> > +       return 0;
> > +}
> > +
> 
> How about returning an error here? You don't actually register the range.

That's not the intention here. I basically want a nop, as by default (read x86)
we do nothing with the IO range.

Best regards,
Liviu

> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
