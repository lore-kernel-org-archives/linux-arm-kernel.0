From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 01 Aug 2014 16:49:46 +0400
Subject: [PATCH 5/6] ARM: DTS: da850-evm: Add node for tlv320aic3106 codec
In-Reply-To: <53DB240F.2030908@ti.com>
References: <1406801934-23334-1-git-send-email-peter.ujfalusi@ti.com>
 <1406801934-23334-6-git-send-email-peter.ujfalusi@ti.com>
 <53DA519A.4090905@cogentembedded.com> <53DB240F.2030908@ti.com>
Message-ID: <53DB8CEA.9010902@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-08-2014 9:22, Peter Ujfalusi wrote:

>>> The board uses aic3106 for audio.

>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>>    arch/arm/boot/dts/da850-evm.dts | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)

>>> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
>>> index 09118c72e83f..b9ef2be0b145 100644
>>> --- a/arch/arm/boot/dts/da850-evm.dts
>>> +++ b/arch/arm/boot/dts/da850-evm.dts
>>> @@ -51,6 +51,20 @@
>>>                tps: tps at 48 {
>>>                    reg = <0x48>;
>>>                };
>>> +            tlv320aic3106: tlv320aic3106 at 1b {

[...]

>> Also, the ePAPR standard [1] says:

>> The name of a node should be somewhat generic, reflecting the function of the
>> device and not its precise programming model.

> True. This is why the node for the audio support is named as 'sound'. For the
> components, like in this case I do not see issue to call the audio codec with
> it's name.

    I do. We should follow the standard consistently. Why not call the node 
"sound-codec"?

WBR, Sergei
