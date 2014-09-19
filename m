From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 19 Sep 2014 14:56:13 -0600
Subject: [PATCH v11 04/10] PCI: OF: Fix the conversion of IO ranges into
 IO resources.
In-Reply-To: <1411003825-21521-5-git-send-email-Liviu.Dudau@arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-5-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140919205613.GG19374@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 02:30:19AM +0100, Liviu Dudau wrote:
> The ranges property for a host bridge controller in DT describes
> the mapping between the PCI bus address and the CPU physical address.
> The resources framework however expects that the IO resources start
> at a pseudo "port" address 0 (zero) and have a maximum size of IO_SPACE_LIMIT.
> The conversion from pci ranges to resources failed to take that into account.
> 
> In the process move the function into drivers/of/address.c as it now
> depends on pci_address_to_pio() code and make it return an error code.

I think you're talking about of_pci_range_to_resource().  Can you split
this into one patch that moves it from of_address.h to of/address.c without
changing its functionality, and a second one that does the actual change?

Bjorn
