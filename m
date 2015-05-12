From: tremyfr@gmail.com (Philippe Reynes)
Date: Wed, 13 May 2015 00:21:08 +0200
Subject: [PATCH] imx27: dt: only map 1 Kbyte for fec registers
In-Reply-To: <20150512070117.GV12671@pengutronix.de>
References: <1431204870-17233-1-git-send-email-tremyfr@gmail.com>
 <20150511120101.GA25495@tiger> <55511E34.5040908@gmail.com>
 <20150512070117.GV12671@pengutronix.de>
Message-ID: <55527CD4.6010208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 12/05/15 09:01, Uwe Kleine-K?nig wrote:
> Hello,
>
> On Mon, May 11, 2015 at 11:25:08PM +0200, Philippe Reynes wrote:
>> On 11/05/15 14:01, Shawn Guo wrote:
>>> On Sat, May 09, 2015 at 10:54:30PM +0200, Philippe Reynes wrote:
>>>> According to the imx27 documentation, fec has a 1 Kbyte
>>>> memory space map, spitted in two regions of 512 bytes.
>>>> The first one for control/status registers, and the
>>>> second one for event/statistic registers. So, we don't
>>>> need to map 16 Kbyte for registers, 1 Kbyte is enough.
>>>>
>>>> Signed-off-by: Philippe Reynes<tremyfr@gmail.com>
>>>> ---
>>>>   arch/arm/boot/dts/imx27.dtsi |    2 +-
>>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
>>>> index 6951b66..56bb917 100644
>>>> --- a/arch/arm/boot/dts/imx27.dtsi
>>>> +++ b/arch/arm/boot/dts/imx27.dtsi
>>>> @@ -533,7 +533,7 @@
>>>>
>>>>   			fec: ethernet at 1002b000 {
>>>>   				compatible = "fsl,imx27-fec";
>>>> -				reg =<0x1002b000 0x4000>;
>>>> +				reg =<0x1002b000 0x400>;
>>>
>>> No.  Per MCIMX27RM.pdf, Table 2-7. AIPI2 Memory Map, it should be 4KiB.
>>
>> I agree, this table show that 4KiB is reserved for fec registers.
>> But, in paragraph 29.6.1, there is :
>> "The FEC implementation requires a 1-Kbyte memory map space"
>> So I've thought that 1 Kbye is enough for the register memory space.
> The table 2-7 suggests that 4 KiB are routed to the fec even though the
> fec module might only make use of the first 1 KiB. That's no
> contradiction. The convention used in the device trees is that the first
> amount is used.

Ok, I understand, thanks for this explaination.

>> I'm pleased to understand that we're both agree that 16 Kbyte is too large.
>>
>> If you prefer 4 Kbyte, I'll send a v2 of this patch with this value.
> Yes please. In the commit log you might want to point out that a length
> of 16 KiB overlaps with the (currently unused?) Security Controller
> (SCC) of the i.MX27.

I've send a new patch (v2 and v3) that map 4 Kbyte for fec registers on imx27.

> Best regards
> Uwe

Best regards,
Philippe
