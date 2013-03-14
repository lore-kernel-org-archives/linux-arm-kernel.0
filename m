From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Mar 2013 19:43:55 -0500
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <5141023C.3010200@firmworks.com>
References: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313213344.GA29402@avionic-0098.mockup.avionic-design.de>
 <5141023C.3010200@firmworks.com>
Message-ID: <51411D4B.4000104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 05:48 PM, Mitch Bradley wrote:
> On 3/13/2013 11:33 AM, Thierry Reding wrote:
>> On Wed, Mar 13, 2013 at 10:58:02AM -1000, Mitch Bradley wrote:
>> [...]
>>> In this case, the answer to "what does pcie_controller do?" is "it
>>> implements a PCI bus" below.  So 'device_type = "pci"' is appropriate.
>>
>> Alright, that's 2 against 1. I don't have much of a choice but to yield.
> 
> All issues of "voting" aside, 'device_type = pci' is what tells
> of_get_pci_address() to use the 3/2 interpretation.  So if you want a
> node to implement 3/2 addresses, it must say device_type = pci, unless
> you do address translation some other way.

I should note that device_type is used for OF, but is supposed to not be
used for FDT as matching against compatible properties is preferred. I
don't have a good reason as to why, but Mitch may know the history.
However, there are numerous exceptions to that for compatibility and to
work with existing s/w. So this may be one of those cases.

Rob
