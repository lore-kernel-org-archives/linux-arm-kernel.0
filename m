From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 1 Feb 2016 22:00:55 +0300
Subject: [PATCH] ARM: dts: porter: add MAX3355 support
In-Reply-To: <56AF9BE8.4020002@cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <4506196.xOgpYRO52t@wasted.cogentembedded.com>
 <SG2PR06MB0919D09C1146EAC0681EE109D8DA0@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <56ABCB69.1070800@cogentembedded.com> <56ABD066.7020804@cogentembedded.com>
 <SG2PR06MB0919361DC5805AE3F5B74041D8DE0@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <56AF9BE8.4020002@cogentembedded.com>
Message-ID: <56AFAB67.20404@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2016 08:54 PM, Sergei Shtylyov wrote:

>>>>>> From: linux-renesas-soc-owner at vger.kernel.org
>>>>>> [mailto:linux-renesas-soc-owner at vger.kernel.org] On Behalf Of Sergei
>>>>>> Shtylyov
>>>>>> Sent: Wednesday, January 27, 2016 7:14 AM
>>>>>>
>>>>>> Now that Maxim Integrated MAX3355 'extcon' driver and device tree bindings
>>>>>> are upstream along with the 'extcon' hook  in the Renesas USBHS driver, we
>>>>>> can add  MAX3355 device node to  the Porter device tree and properly refer
>>>>>> to it from the USBHS node instead of using  "renesas,enable-gpio" property
>>>>>> which only allowed checking the USB ID pin  at the driver probe time;  now
>>>>>> this  pin's  state can be monitored dynamically!
>>>>>>
>>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>>>
>>>>> I tested this patch on Porter, but interrupt of "usb-otg" didn't happened
>>>>> even if I connected/disconnected a usb convert cable (usb micro-ab to A).
>>>>> Remarks: I confirmed that the usb convert cable worked correctly on other
>>>>> board.
>>>>
>>>>      I guess I have the same cable
>>>
>>>      No, I have mini-AB connector here and hence my cable is mini-AB to A.
>>
>> I checked Porter specification and then I found 2 specifications exist...
>
>     I've looked thru my schematics files and found 3: Rev. 1.1 Update Version
> 2, "PORTER_2" Rev. 3.0 Preliminary, and "PORTER_C" Rev. 3.0 Release version!
> I'm not sure which of the last 2 should be considered final...

    Now I've found 5 versions of the Porter schematics... :-)

>>   Porter "B" : mini AB connecter and Max3355 is on the board.
>>   Porter "C" : micro AB connect and Max3355 is not on the board. (Select
>> host/peripheral by a jumper.)
>
>     Yeah, seeing JP13 in the PORTER_C schematics.
>
>> I guess that your current target is "B".
>
>     If not earlier. It actually has "Henninger B REV2" printed on it and
> "Porter PCB 1 R3" on a pasted sticker.
>
>> If so, I think this patch is acceptable.
>
>     I'm not so sure now...

    My boss told me PORTER_C is a final version, so this patch isn't needed. 
But then another patch is needed instead: to remove "renesas,enable-gpio" prop 
from the HS-USB device node...

>> Best regards,
>> Yoshihiro Shimoda

MBR, Sergei
