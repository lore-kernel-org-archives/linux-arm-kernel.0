From: arend@broadcom.com (Arend van Spriel)
Date: Thu, 11 Dec 2014 10:44:30 +0100
Subject: [PATCH 2/4] PCI: iproc: Add Broadcom iProc PCIe driver
In-Reply-To: <CAGVrzcbZ_f43Vf1mu2XErVi_Jehjggh2TREyrSs84ntSm98yvg@mail.gmail.com>
References: <1418169871-19232-3-git-send-email-rjui@broadcom.com>
 <9707535.Y78sV0TgX4@wuerfel> <54887901.8070501@broadcom.com>
 <CAGVrzcbZ_f43Vf1mu2XErVi_Jehjggh2TREyrSs84ntSm98yvg@mail.gmail.com>
Message-ID: <5489677E.3000607@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Rafal

On 12/10/14 19:46, Florian Fainelli wrote:
> 2014-12-10 8:46 GMT-08:00 Scott Branden<sbranden@broadcom.com>:
>> On 14-12-10 03:31 AM, Arnd Bergmann wrote:
>>>
>>> On Tuesday 09 December 2014 16:04:29 Ray Jui wrote:
>>>>
>>>> Add initial version of the Broadcom iProc PCIe driver. This driver
>>>> has been tested on NSP and Cygnus and is expected to work on all iProc
>>>> family of SoCs that deploys the same PCIe host controller
>>>>
>>>> The driver also supports MSI
>>>>
>>>> Signed-off-by: Ray Jui<rjui@broadcom.com>
>>>> Reviewed-by: Scott Branden<sbranden@broadcom.com>
>>>
>>>
>>> The driver looks suspiciously like the one that Hauke already submitted a
>>> while ago for bcm53xx. Please come up with a merged driver that works for
>>> both.
>>
>> Could you please be a little more specific.  What driver did "Hauke already
>> submitted"?  I do not see any driver in the kernel you are talking about.
>
> https://www.marc.info/?l=linux-pci&m=141547043110684&w=2
>
>>>
>>>
>>> Are you sure that iProc isn't based on the BCMA bus infrastructure after
>>> all? Even the physical address of your PCI host falls into the address
>>> range that is used for the internal BCMA bus on the other chips!
>>
>> BCMA seems to be for MIPS architectures.  It seems to be quite specific to
>> those architectures using BCMA.  I see no use of it in bcm53xx code?
>
> BCMA lives in its own directory in drivers/bcma/ and is not specific
> to MIPS actually. Older BCM47xx/BCM53xx MIPS-based SoCs traditionally
> started with a discoverable Silicon Sonics Backplane (drivers/ssb) and
> progressively migrated to BCMA (drivers/bcma), both subsystems offer a
> very similar bus/device/driver abstraction and discovery mechanism.

BCMA core is the bus driver for discoverable ARM AXI interconnect. Apart 
from that it also provides drivers for some cores. For the chips to be 
discoverable it needs additional IP logic. If that is not used in the 
iProc family devices, it can not use the BCMA-based PCIe controller 
driver that Hauke submitted unless BCMA would provide an API to provide 
the chips' core information statically either per core or a full list.

Regards,
Arend
