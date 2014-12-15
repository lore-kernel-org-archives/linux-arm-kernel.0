From: rjui@broadcom.com (Ray Jui)
Date: Mon, 15 Dec 2014 11:16:31 -0800
Subject: [PATCH v2 2/4] PCI: iproc: Add Broadcom iProc PCIe driver
In-Reply-To: <1790462.K12S5vem48@wuerfel>
References: <1418351817-14898-3-git-send-email-rjui@broadcom.com>
 <2190666.DfrpWiLTCc@wuerfel> <548B2120.4080207@broadcom.com>
 <1790462.K12S5vem48@wuerfel>
Message-ID: <548F338F.9030203@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/12/2014 9:21 AM, Arnd Bergmann wrote:
> On Friday 12 December 2014 09:08:48 Ray Jui wrote:
>>
>> On 12/12/2014 4:29 AM, Arnd Bergmann wrote:
>> Doesn't Hauke's driver depends on BCMA? In that case, how does it work
>> on the SoCs that do not have the IP block to support BCMA?
>
> I hadn't realized that there are some SoCs that are not BCMA based.
> As the host controller implementation is closely related, we will
> have to come up with some solution.
>
I agree with you that we should have a common PCIe host driver which 
supports all iProc SoCs, BCM4708, BCM5301X, and some other similar SoCs.

> One way to solve this would be by turning the driver into a library
> the same way as the pcie-dw driver, and have separate front-ends
> for it for platform_device and bcma_device.
>
I'm fine with this solution, i.e., to introduce a common pcie-iproc core 
driver (just like pcie-designware) and have different front-ends 
depending on the device/bus type. If we end up deciding to go with this 
solution, I need to discuss with Hauke to come up with a plan to 
collaborate.

But before we choose to go with that route, may I ask, what is the 
purpose of tying a PCIe host driver to BCMA? What benefit does BCMA give 
us? If we have a generic platform based PCIe driver that can work on all 
iProc SoCs + BCM4708 and BCM5301X with all HW specific configurations 
taken care of by device tree, why do we still need to use BCMA?

I thought all a BCMA device here does is to auto-instantiate based on 
some register readings?
