From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 12:24:48 +0200
Subject: [PATCH] PCI: keystone: update to support multiple pci ports
In-Reply-To: <540DD0CF.4000501@ti.com>
References: <1409938782-31460-1-git-send-email-m-karicheri2@ti.com>
 <5769746.NkKjYOOUiv@wuerfel> <540DD0CF.4000501@ti.com>
Message-ID: <5974944.bS5MvrslRo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 11:52:47 Murali Karicheri wrote:
> On 09/05/2014 05:11 PM, Arnd Bergmann wrote:
> > But the driver can only do root complex mode, and we would probably
> > want a completely different driver if we were to start supporting
> > endpoint mode.
> 
> Good point! I will drop index#2 handling in the driver code and will 
> handle the same in boot loader. But I have a question though. The 
> original driver which is queued up for merge to v3.18 has index #2 for 
> this reg offset and is documented in the DT documentation as
> 
> 	index 2 is the base address and length of PCI mode configuration
> 	register.
> 	index 3 is the base address and length of PCI device ID register.
> 
> 
> Will this create any issue in terms of backward compatibility if I 
> remove it and move index3 to index2 and update the code for the same? I 
> assume since this patch also will likely be on the next branch soon, and 
> gets merged together with original driver to v3.18, this should be fine. 
> But for some reason, if this patch doesn't make to v3.18, then won't 
> this break the backward compatibility?
> 
> I think the other option is document index2 as obsolete and update the 
> document and remove the code for handling it. Any suggestion?

Since the driver is not merged into Linus' tree yet and (more importantly)
has not been in a release yet, we can still fix it. Please just send a
patch on top to remove it now, it's not too late yet.

	Arnd
