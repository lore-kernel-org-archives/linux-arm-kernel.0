From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Jan 2013 15:17:01 -0700
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130129225932.01efb45b@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301291645.08040.arnd@arndb.de> <20130129180936.3737e550@skate>
 <201301292015.21478.arnd@arndb.de> <20130129213308.7e845064@skate>
 <20130129225932.01efb45b@skate>
Message-ID: <51084A5D.3080406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 02:59 PM, Thomas Petazzoni wrote:
> Arnd,
> 
> On Tue, 29 Jan 2013 21:33:08 +0100, Thomas Petazzoni wrote:
> 
>> Basically, I have currently two suggestions:
>>
>>  * From Jason Gunthorpe, to not use any host bridge, and instead use
>>    only PCI-to-PCI bridges, one per PCIe interface.
>>
>>  * From you, to not use any PCI-to-PCI bridge, and use only host
>>    bridges, one per PCIe interface.
> 
> Thinking more about this, this solution (using one emulated host bridge
> per PCIe interface) would cause one problem: the PCIe device itself
> would no longer be in slot 0.

I think that's device 0 not slot 0 right?

> If I'm correct, with one host bridge per PCIe interface, we would have
> the following topology:
> 
>  bus 0, slot 0: emulated host bridge 0
>  bus 0, slot 1: PCIe device connected to PCIe interface 0

I /think/ the bus that the root port itself is on is different from the
bus that the downstream device is on, so wouldn't you end up with:

bus 0, slot 0: emulated host bridge 0
bus 1, slot 0: PCIe device connected to PCIe interface 0

(and isn't that "root port" not "host bridge" in the first line above?)
