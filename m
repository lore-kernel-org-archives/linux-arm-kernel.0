From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Dec 2012 13:34:08 -0600
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <20121212215138.GC11530@obsidianresearch.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111056.58970.arnd@arndb.de> <20121212165833.6a35a6ec@skate>
 <20121212215138.GC11530@obsidianresearch.com>
Message-ID: <50CB7F30.9090305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 03:51 PM, Jason Gunthorpe wrote:
> On Wed, Dec 12, 2012 at 04:58:33PM +0100, Thomas Petazzoni wrote:
> 
>> and the global physical address space is limited in size, we definitely
>> do not want to have static mappings at fixed physical addresses
>> hardcoded in the Device Tree.
> 
> Unfortunately DT pretty much requires that all PCI host bridges hard
> code the addresess. The expectation seems in many cases that the BIOS
> will do assignment and discovery and just propagate it into the DT
> format.

The DT is not fixed. You can make run-time changes if needed. As I
mentioned in the other thread on PCI and DT, you could set or update the
ranges property within your PCI host driver with the addresses you end
up using. Or omitting the ranges property would also work if you have no
child devices (which is typical).

Rob
