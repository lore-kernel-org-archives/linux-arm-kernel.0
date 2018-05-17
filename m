From: liwei213@huawei.com (liwei (CM))
Date: Thu, 17 May 2018 00:50:23 +0000
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2OSAyLzVdIGR0LWJpbmRpbmdzOiBz?=
 =?utf-8?Q?csi:_ufs:_add_document_for_hisi-ufs?=
In-Reply-To: <CAL_JsqLf_r=NHHP2ZNEJOoLORXztF1KnU+tq-+COt4CPMLAsiA@mail.gmail.com>
References: <20180417140814.38098-1-liwei213@huawei.com>
 <20180417140814.38098-3-liwei213@huawei.com>
 <20180424125827.k2dgeu6uon75wzni@rob-hp-laptop>
 <1699CE87DE933F49876AD744B5DC140FA5AC86@DGGEMM506-MBS.china.huawei.com>
 <CAL_JsqLf_r=NHHP2ZNEJOoLORXztF1KnU+tq-+COt4CPMLAsiA@mail.gmail.com>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA63AC2@DGGEMM506-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Rob

-----????-----
???: Rob Herring [mailto:robh at kernel.org] 
????: 2018?5?16? 21:16
???: liwei (CM)
??: mark.rutland at arm.com; catalin.marinas at arm.com; will.deacon at arm.com; vinholikatti at gmail.com; jejb at linux.vnet.ibm.com; martin.petersen at oracle.com; khilman at baylibre.com; arnd at arndb.de; gregory.clement at free-electrons.com; thomas.petazzoni at free-electrons.com; yamada.masahiro at socionext.com; riku.voipio at linaro.org; treding at nvidia.com; krzk at kernel.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-scsi at vger.kernel.org; zangleigang; Gengjianfeng; guodong.xu at linaro.org
??: Re: ??: [PATCH v9 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

On Tue, Apr 24, 2018 at 8:54 AM, liwei (CM) <liwei213@huawei.com> wrote:
> Hi, Rob
>
> Thanks for your patience.
>
> Hi, Arnd
>
> From Rob's suggestion, we have to list the properties node in ufs-hisi.txt bingings even if documented in the common binding.
>
> -----????-----
> ???: Rob Herring [mailto:robh at kernel.org]
> ????: 2018?4?24? 20:58
> ???: liwei (CM)
> ??: mark.rutland at arm.com; catalin.marinas at arm.com; will.deacon at arm.com; vinholikatti at gmail.com; jejb at linux.vnet.ibm.com; martin.petersen at oracle.com; khilman at baylibre.com; arnd at arndb.de; gregory.clement at free-electrons.com; thomas.petazzoni at free-electrons.com; yamada.masahiro at socionext.com; riku.voipio at linaro.org; treding at nvidia.com; krzk at kernel.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-scsi at vger.kernel.org; zangleigang; Gengjianfeng; guodong.xu at linaro.org
> ??: Re: [PATCH v9 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs
>
> On Tue, Apr 17, 2018 at 10:08:11PM +0800, Li Wei wrote:
>> add ufs node document for Hisilicon.
>>
>> Signed-off-by: Li Wei <liwei213@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 29 ++++++++++++++++++++++
>>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      | 10 +++++---
>>  2 files changed, 36 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>> new file mode 100644
>> index 000000000000..d49ab7d8f31d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>> @@ -0,0 +1,29 @@
>> +* Hisilicon Universal Flash Storage (UFS) Host Controller
>> +
>> +UFS nodes are defined to describe on-chip UFS hardware macro.
>> +Each UFS Host Controller should have its own node.
>> +
>> +Required properties:
>> +- compatible        : compatible list, contains one of the following -
>> +                                     "hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
>> +                                     host controller present on Hi36xx chipset.
>> +- reg               : should contain UFS register address space & UFS SYS CTRL register address,
>> +- interrupt-parent  : interrupt device
>> +- interrupts        : interrupt number
>> +- resets            : reset node register, the "arst" corresponds to reset the APB/AXI bus.
>
> arst belongs in reset-names.
>
> OK, I will fix it in next patch;
>
>> +- reset-names       : describe reset node register
>
> What happened to clocks? You still have to list which ones apply even if
> documented in the common binding.
>
> OK, I will fix it in next patch;
>
>> +
>> +Example:
>> +
>> +     ufs: ufs at ff3b0000 {
>> +             compatible = "hisilicon,hi3660-ufs", "jedec,ufs-1.1";
>> +             /* 0: HCI standard */
>> +             /* 1: UFS SYS CTRL */
>> +             reg = <0x0 0xff3b0000 0x0 0x1000>,
>> +                     <0x0 0xff3b1000 0x0 0x1000>;
>> +             interrupt-parent = <&gic>;
>> +             interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
>> +             /* offset: 0x84; bit: 7  */
>> +             resets = <&crg_rst 0x84 7>;
>> +             reset-names = "arst";
>> +     };
>> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> index c39dfef76a18..adcfb79f63f5 100644
>> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> @@ -41,6 +41,8 @@ Optional properties:
>>  -lanes-per-direction : number of lanes available per direction - either 1 or 2.
>>                         Note that it is assume same number of lanes is used both
>>                         directions at once. If not specified, default is 2 lanes per direction.
>> +- resets            : reset node register, the "rst" corresponds to reset the whole UFS IP.
>> +- reset-names       : describe reset node register
>
> Does your controller have 1 or 2 resets? There's no point in adding this
> here if it doesn't apply to your controller.
>
> There are 2 reset in our soc init, the "rst" corresponds to reset the whole UFS IP, and " arst " only reset the APB/AXI bus.
> Discussed with our soc colleagues that "arst" is assert by default and needs to deassert,but it done in bootloader,so will remove 'arst' in next patch.
>
> About the 'reset' property?it seems that Arnd Bergmann has different suggestion?he suggested that add 'rst' to ufshcd-pltfrm because it seems common.
> But it looks like only our soc init needs it. What's your opinion? Does it still needs add to common bindings?

For a single reset, then I'm fine with it being in the common
bindings. If there are multiple then it should be in the specific
bindings as the reset names are likely different.

OK, I will remove the 'arst' and keep only 'rst' in tne common bingings.

Rob
