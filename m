From: monstr@monstr.eu (Michal Simek)
Date: Mon, 10 Mar 2014 12:58:56 +0100
Subject: [RFC PATCH] edac: zynq: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <20140310105655.GH14999@e106331-lin.cambridge.arm.com>
References: <4adb2b4b-2ad6-42b9-929e-cc062f817245@TX2EHSMHS021.ehs.local>
 <20140310105655.GH14999@e106331-lin.cambridge.arm.com>
Message-ID: <531DA900.5060202@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2014 11:56 AM, Mark Rutland wrote:
> On Sun, Mar 09, 2014 at 02:57:16AM +0000, Punnaiah Choudary Kalluri wrote:
>> Added EDAC support for reporting the ecc errors of zynq ddr controller.
>> The ddr ecc controller corrects single bit errors and detects double bit
>> errors
>>
>> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
>> ---
>>  .../devicetree/bindings/edac/zynq_edac.txt         |   18 +
>>  drivers/edac/Kconfig                               |    7 +
>>  drivers/edac/Makefile                              |    1 +
>>  drivers/edac/zynq_edac.c                           |  613 ++++++++++++++++++++
>>  4 files changed, 639 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/edac/zynq_edac.txt
>>  create mode 100644 drivers/edac/zynq_edac.c
>>
>> diff --git a/Documentation/devicetree/bindings/edac/zynq_edac.txt b/Documentation/devicetree/bindings/edac/zynq_edac.txt
>> new file mode 100644
>> index 0000000..c21ff83
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/zynq_edac.txt
>> @@ -0,0 +1,18 @@
>> +Zynq EDAC driver, it does reports the DDR ECC single bit errors that are
>> +corrected and double bit ecc errors that are detected by the DDR ECC controller.
>> +ECC support for DDR is available in half-bus width(16 bit) configuration only.
>> +
>> +Required properties:
>> +- compatible: Should be "xlnx,ps7-ddrc" or "xlnx,ps7-ddrc-1.00.a"
> 
> Is this an or or a xor?

Compatible string should be just xlnx,zynq-ddrc-1.00.a.
Nothing with ps7.

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/e9df4092/attachment.sig>
