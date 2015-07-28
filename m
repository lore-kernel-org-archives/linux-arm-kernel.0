From: monstr@monstr.eu (Michal Simek)
Date: Tue, 28 Jul 2015 07:41:27 +0200
Subject: [RFCv2 1/3] docs: dts: Added documentation for Xilinx Zynq Reset
 Controller bindings.
In-Reply-To: <CAAtXAHeWtXVe4c5z_6AxMS0CggA2pN57mNArJsKG9=QxWs-zRw@mail.gmail.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-2-git-send-email-moritz.fischer@ettus.com>
 <55B5BD08.60802@monstr.eu>
 <CAAtXAHeWtXVe4c5z_6AxMS0CggA2pN57mNArJsKG9=QxWs-zRw@mail.gmail.com>
Message-ID: <55B71607.1020303@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2015 06:55 AM, Moritz Fischer wrote:
> Hi Michal,
> 
> On Sun, Jul 26, 2015 at 10:09 PM, Michal Simek <monstr@monstr.eu> wrote:
>> On 07/25/2015 02:21 AM, Moritz Fischer wrote:
>>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>>> ---
>>>  Documentation/devicetree/bindings/reset/zynq-reset-pl.txt | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>>> new file mode 100644
>>> index 0000000..ac4499e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>>> @@ -0,0 +1,13 @@
>>> +Xilinx Zynq PL Reset Manager
>>
>> here
>>
>>> +
>>> +Required properties:
>>> +- compatible: "xlnx,zynq-reset-pl"
>>
>> Currently it is not just PL reset controller.
>>
>>> +- syscon <&slcr>;
>>
>>
>> missing : and please be more descriptive here.
>>
>>> +- #reset-cells: 1
>>> +
>>> +Example:
>>> +     rstc: rstc at 240 {
>>> +             #reset-cells = <1>;
>>> +             compatible = "xlnx,zynq-reset-pl";
>>
>> Compatible property should go first.
>>
>> I am missing that reg property
>>
>>> +             syscon = <&slcr>;
>>> +     };
>>>
>>
> Would something like this work:
> 
> Xilinx Zynq Reset Manager
> 
> The Zynq AP-SoC has several different resets.
> 
> See Chapter 26 of the Zynq TRM (UG585) for more information about Zynq resets.
> 
> Required properties:
> - compatible: "xlnx,zynq-reset"
> - reg: SLCR offset and size taken via syscon <0x200 0x50>
> - syscon: <&slcr>
>   This should be a phandle to the Zynq's SLCR register.
> - #reset-cells: Must be 1
> 
> The Zynq Reset Manager needs to be a child node of the SLCR.
> 
> Example:
>         rstc: rstc at 200 {
>                 compatible = "xlnx,zynq-reset";
>                 reg = <0x200 0x50>;
>                 #reset-cells = <1>;
>                 syscon = <&slcr>;
>         };

Looks good to me.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150728/aa2596c1/attachment.sig>
