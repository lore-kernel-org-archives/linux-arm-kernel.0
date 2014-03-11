From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Tue, 11 Mar 2014 07:25:24 +0000
Subject: [RFC PATCH] edac: zynq: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <531DA900.5060202@monstr.eu>
References: <4adb2b4b-2ad6-42b9-929e-cc062f817245@TX2EHSMHS021.ehs.local>
 <20140310105655.GH14999@e106331-lin.cambridge.arm.com>
 <531DA900.5060202@monstr.eu>
Message-ID: <2da88be0-6cbf-4cf5-9aa9-453084863da7@TX2EHSMHS038.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Michal Simek [mailto:monstr at monstr.eu]
>Sent: Monday, March 10, 2014 5:29 PM
>To: Mark Rutland
>Cc: Punnaiah Choudary Kalluri; dougthompson at xmission.com;
>devicetree at vger.kernel.org; linux-doc at vger.kernel.org; linux-arm-
>kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
>edac at vger.kernel.org; Michal Simek; robh+dt at kernel.org; Pawel Moll;
>ijc+devicetree at hellion.org.uk; galak at codeaurora.org; rob at landley.net;
>kpc528 at gmail.com; kalluripunnaiahchoudary at gmail.com; Punnaiah Choudary
>Kalluri
>Subject: Re: [RFC PATCH] edac: zynq: Added EDAC support for zynq ddr ecc
>controller
>
>On 03/10/2014 11:56 AM, Mark Rutland wrote:
>> On Sun, Mar 09, 2014 at 02:57:16AM +0000, Punnaiah Choudary Kalluri
>wrote:
>>> Added EDAC support for reporting the ecc errors of zynq ddr controller.
>>> The ddr ecc controller corrects single bit errors and detects double
>>> bit errors
>>>
>>> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
>>> ---
>>>  .../devicetree/bindings/edac/zynq_edac.txt         |   18 +
>>>  drivers/edac/Kconfig                               |    7 +
>>>  drivers/edac/Makefile                              |    1 +
>>>  drivers/edac/zynq_edac.c                           |  613 ++++++++++++++++++++
>>>  4 files changed, 639 insertions(+), 0 deletions(-)  create mode
>>> 100644 Documentation/devicetree/bindings/edac/zynq_edac.txt
>>>  create mode 100644 drivers/edac/zynq_edac.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/edac/zynq_edac.txt
>>> b/Documentation/devicetree/bindings/edac/zynq_edac.txt
>>> new file mode 100644
>>> index 0000000..c21ff83
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/edac/zynq_edac.txt
>>> @@ -0,0 +1,18 @@
>>> +Zynq EDAC driver, it does reports the DDR ECC single bit errors that
>>> +are corrected and double bit ecc errors that are detected by the DDR ECC
>controller.
>>> +ECC support for DDR is available in half-bus width(16 bit) configuration
>only.
>>> +
>>> +Required properties:
>>> +- compatible: Should be "xlnx,ps7-ddrc" or "xlnx,ps7-ddrc-1.00.a"
>>
>> Is this an or or a xor?
>
>Compatible string should be just xlnx,zynq-ddrc-1.00.a.
>Nothing with ps7.
Hi Mark and Michal,

I will correct the binding info and send the next version

Regards,
Punnaiah
>
>Thanks,
>Michal
>
>
>--
>Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
>w: www.monstr.eu p: +42-0-721842854
>Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
>Maintainer of Linux kernel - Xilinx Zynq ARM architecture Microblaze U-BOOT
>custodian and responsible for u-boot arm zynq platform
>



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
