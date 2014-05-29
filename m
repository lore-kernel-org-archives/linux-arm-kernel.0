From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 29 May 2014 11:03:36 -0500
Subject: [PATCH v2 03/18] PCI: designware: Configuration space should be
 specified in 'reg'
In-Reply-To: <20140529151840.GD1677@bart.dudau.co.uk>
References: <1401345500-20188-1-git-send-email-kishon@ti.com>
 <1401345500-20188-4-git-send-email-kishon@ti.com>
 <98E18225-3C63-4106-901A-A5D3DEC268C8@codeaurora.org>
 <20140529151840.GD1677@bart.dudau.co.uk>
Message-ID: <CF1BAF3F-E16E-4864-8052-8C3EC29000B0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 29, 2014, at 10:18 AM, Liviu Dudau <liviu@dudau.co.uk> wrote:

> On Thu, May 29, 2014 at 10:03:54AM -0500, Kumar Gala wrote:
>> 
>> On May 29, 2014, at 1:38 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> 
>>> The configuration address space has so far been specified in *ranges*,
>>> however it should be specified in *reg* making it a platform MEM resource.
>>> Hence used 'platform_get_resource_*' API to get configuration address
>>> space in the designware driver.
>>> 
>>> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Mohit Kumar <mohit.kumar@st.com>
>>> Cc: Jingoo Han <jg1.han@samsung.com>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>> .../devicetree/bindings/pci/designware-pcie.txt    |    1 +
>>> drivers/pci/host/pcie-designware.c                 |   17 +++++++++++++++--
>>> 2 files changed, 16 insertions(+), 2 deletions(-)
>> 
>> Why should the cfg space be defined in *reg* instead of ranges?
> 
> Because what you end up using is a struct resource to represent the cfg space and
> the conversion between ranges and resources breaks down for CFG space (we don't
> have a flag in the resource flags to say this is CFG resource). Specifying it
> as a *reg* property makes it a MEM resource and no special casing is needed.
> 
> Best regards,
> Liviu

Just because the kernel doesn?t handle this is NO reason to change the way the DT works.

We are probably better of changing of_bus_pci_get_flags() to set IORESOURCE_MEM for cfg type.  Will send a patch for this.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
