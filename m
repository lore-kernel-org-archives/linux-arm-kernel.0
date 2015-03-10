From: rjui@broadcom.com (Ray Jui)
Date: Tue, 10 Mar 2015 14:02:37 -0700
Subject: [PATCH v5 1/4] PCI: Export symbols of PCI functions
In-Reply-To: <20150310205651.GA32204@google.com>
References: <1425947886-23705-1-git-send-email-rjui@broadcom.com>
 <1425947886-23705-2-git-send-email-rjui@broadcom.com>
 <20150310205651.GA32204@google.com>
Message-ID: <54FF5BED.9090302@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 3/10/2015 1:56 PM, Bjorn Helgaas wrote:
> On Mon, Mar 09, 2015 at 05:38:03PM -0700, Ray Jui wrote:
>> Export symbols of the following PCI functions so they can be referenced
>> by a PCI driver compiled as a kernel loadable module:
>>
>> pci_common_swizzle
>> pci_create_root_bus
>> pci_stop_root_bus
>> pci_remove_root_bus
>> pci_assign_unassigned_bus_resources
>> pci_fixup_irqs
> 
> Have you tested your driver as a loadable module?
> 
> If it works to load/unload/reload/etc., I'm OK with exporting these
> symbols.  I would prefer EXPORT_SYMBOL_GPL, though, because these don't
> constitute a very coherent interface right now, and they will likely be
> reworked.  For example, see Yijing Wang's work to sort out the
> pci_bus_add_devices() / resource assignment mess.
> 
> Bjorn

Yes, I tested the driver with load/unload/reload on Cygnus. Console logs
are included in my reply to Arnd's email from another email thread.

I'll wait for more feedback from you on the iProc PCIe driver itself.
But if you have reviewed them and think they are okay then I can go
ahead and submit v6 with changes to use EXPORT_SYMBOL_GPL.

Let me know.

Thanks,

Ray
