From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 18 Nov 2014 08:56:29 +0100
Subject: [PATCH v4 6/6] ARM: zynq: DT: Add OCM controller node
In-Reply-To: <CAEgOgz7j3jFbf1HxtimzPDMQ3oRu8AAHhHAUtg1boYjOUV5ygA@mail.gmail.com>
References: <cover.1415962281.git.michal.simek@xilinx.com>
 <0a88d52b5e71fb220ca619180ec9ca746edad2b1.1415962281.git.michal.simek@xilinx.com>
 <546881CA.2020801@suse.de>
 <c52187589f5c4cc6b908d899c2b9f7a6@BN1BFFO11FD036.protection.gbl>
 <CAEgOgz7j3jFbf1HxtimzPDMQ3oRu8AAHhHAUtg1boYjOUV5ygA@mail.gmail.com>
Message-ID: <d7d71aa91adc49e5890fe3d64caed4bf@BN1BFFO11FD034.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2014 12:00 AM, Peter Crosthwaite wrote:
> On Mon, Nov 17, 2014 at 5:32 AM, S?ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
>> On Sun, 2014-11-16 at 11:51AM +0100, Andreas F?rber wrote:
>>> Hi Michal,
>>>
>>> Am 14.11.2014 um 11:52 schrieb Michal Simek:
>>>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>>>> index ce2ef5bec4f2..e217fb1c1169 100644
>>>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>>>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>>>> @@ -150,6 +150,13 @@
>>>>                     reg = <0xf8006000 0x1000>;
>>>>             };
>>>>
>>>> +           ocmc: memory-controller at f800c000 {
>>>> +                   compatible = "xlnx,zynq-ocmc-1.0";
>>>> +                   interrupt-parent = <&intc>;
>>>> +                   interrupts = <0 3 4>;
>>>> +                   reg = <0xf800c000 0x1000>;
>>>> +           };
>>>> +
>>>>             uart0: serial at e0000000 {
>>>>                     compatible = "xlnx,xuartps", "cdns,uart-r1p8";
>>>>                     status = "disabled";
>>>
>>> Not directly related to this patch: As one can see here, the node order
>>> is quite a mess... According to Olof, nodes should be ordered by unit
>>> address, whereas here some but not all seem ordered by node name. Would
>>> you welcome a cleanup patch, or can you fix that yourself?
>>
>> I wouldn't say it's a mess, just a different property to sort the nodes
>> by. For humans reading the DT, searching for nodes, alphabetical order
>> helps finding the right node, IMHO.
> 
> I do generally find myself asking "whats that thing at that address"
> more than I find myself asking the "wheres that piece of hardware" so
> Andreas' sorting scheme makes more sense to me. Vertically scanning a
> DT to give yourself an overview of the system level address map is
> good too. Wheras alphabetic sorting doesn't mean to much.

IMHO the reason why we have names in DT is that it is easily to read/understand them
that's why name sorting seems to me more reasonable.
Something like machine code and assembler - asm is also sorted by names not by opcode.

Is this strict rule?

Thanks,
Michal
