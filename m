From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jul 2012 09:17:56 -0500
Subject: [PATCH v2 10/15] ARM: kirkwood: use fixed PCI i/o mapping
In-Reply-To: <20120716071057.GB2163@lunn.ch>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <1342231451-28861-11-git-send-email-robherring2@gmail.com>
 <20120716071057.GB2163@lunn.ch>
Message-ID: <50042294.70809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2012 02:10 AM, Andrew Lunn wrote:
> On Fri, Jul 13, 2012 at 09:04:06PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>

...

>>  	pp->res[1].name = "PCIe 0 MEM";
> 
> ...
> 
>>  	if (request_resource(&iomem_resource, &pp->res[1]))
>>  		panic("Request PCIe%d Memory resource failed\n", index);
>>  
>> -	sys->io_offset = 0;
>> -	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->io_offset);
>>  	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
> 
> pp->res[0] is now unused. Do you plan to also clean up the PCI MEM
> space at some point? And then at the same time remove the rest of this
> code?

I think we should follow what Tegra is doing and convert PCI hosts to
platform drivers (see DT support for Tegra PCI). Then this resource
would be one of the device resources. A simpler change would be moving
this resource into pci_sys_data struct. I may do the latter, but don't
plan to do the former.

I should go back and change this to a single resource though.

Rob

> 
> Thanks
> 	Andrew
> 
