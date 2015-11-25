From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 20:55:49 +0100
Subject: [PATCH] ARM/PCI: move align_resource function pointer into
 pci_host_bridge structure
In-Reply-To: <20151125193201.GE8869@localhost>
References: <1447204345-143793-1-git-send-email-gabriele.paoloni@huawei.com>
 <20151125193201.GE8869@localhost>
Message-ID: <3151909.Tqkjp0h634@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 13:32:01 Bjorn Helgaas wrote:
> On Wed, Nov 11, 2015 at 09:12:25AM +0800, Gabriele Paoloni wrote:
> > From: gabpao01 <gabriele.paoloni@huawei.com>
> > 
> > commit b3a72384fe29 ("ARM/PCI: Replace
> > pci_sys_data->align_resource with global function pointer") has
> > introduced a global function pointer that makes the ARM specific
> > code not portable and broken in case any platform have a two
> > different HW IPs for the PCIe host bridge controller.
> > This patch moves align_resource function pointer into
> > pci_host_bridge structure so that the code is now suitable to be
> > reworked as we want to get rid of hw_pci structure (the host bridge
> > drivers can just set the align function pointer in the
> > pci_host_bridge structure) and there is no more broken code for a
> > SoC with two HW IPs.
> > 
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> 
> This looks good to me.  I merged b3a72384fe29 so maybe it would make
> sense for me to merge this follow-up as well.  I put it on my
> for-linus branch for v4.4.
> 
> If you'd rather merge it via an ARM tree, here's my ack:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> If you want me to merge it, an ARM ack would be nice.  If you want to
> merge it, let me know and I'll drop it from my tree.
> 
> > +     /* Resource alignement requirements     */
> 
> s/alignement/alignment/
> 
> > +     resource_size_t (*align_resource)(struct pci_dev *dev,
> > ...
> 

I was the one who asked for this change, so you can definitely have my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

If Russell wants to take it through his tree, Gabriele can submit it
to http://www.arm.linux.org.uk/developer/patches/, otherwise I'd
suggest we merge it through your tree, as that was also the source
of the patch we are trying to fix up.

	Arnd
