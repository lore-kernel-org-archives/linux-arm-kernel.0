From: monstr@monstr.eu (Michal Simek)
Date: Tue, 12 Aug 2014 11:37:22 +0200
Subject: [PATCH v5] pcie: Add Xilinx PCIe Host Bridge IP driver
In-Reply-To: <CA+mB=1LeZn1k2VHNby2TRBcb1xuFFTQio=C845_xe2A=ZciYqg@mail.gmail.com>
References: <1406131381-25577-1-git-send-email-sthokal@xilinx.com>	<CA+mB=1JhDF=BBXcyTbgVB8S7qH=Mb1JH78HLL4pA9OBH19hQvA@mail.gmail.com>	<8258903.Rn4s07GKGV@wuerfel>
 <CA+mB=1LeZn1k2VHNby2TRBcb1xuFFTQio=C845_xe2A=ZciYqg@mail.gmail.com>
Message-ID: <53E9E052.3070308@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 07/30/2014 01:24 PM, Srikanth Thokala wrote:
> Hi Arnd,
> 
> On Mon, Jul 28, 2014 at 6:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Monday 28 July 2014 18:04:34 Srikanth Thokala wrote:
>>> Hi Arnd and Rob,
>>>
>>> I discussed with Bjorn and we believe this patch is in good shape to
>>> apply.  And Bjorn requires ACKs to apply this patch.  So, could you
>>> guys please review this patch and provided your ACKs to this patch.
>>
>> Looks great for the most part. I've looked through the whole driver
>> again, and I have two small issues remaining:
>>
>> a) Please clarify in the changeset description why there is no support
>>    for PCI I/O space.
> 
> Sure, I will add to my changeset.
> 
>>
>> b) I think you should use the 'msi-parent' property, and the
>>    of_pci_find_msi_chip_by_node() to find the msi_chip for the
>>    PCI controller. This will make it possible to forward MSIs
>>    to the main interrupt controller in the system, which is more
>>    efficient. See the pcie-mvebu driver for an example of this.
> 
> Ok, I need to look into this and I will plan to implement on top of this patch.
> 
>>
>> Other than these:
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks Arnd for the Ack.

What's the status on this one?

Srikanth:
Isn't pcie-xilinx.c better name if this is just pcie host bridge?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140812/8e618580/attachment.sig>
