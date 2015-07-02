From: binmlist@gmail.com (Bin Liu)
Date: Thu, 2 Jul 2015 12:05:36 -0500
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <5594E56B.3040200@free-electrons.com>
References: <20150514190429.GT24269@saruman.tx.rr.com>
 <CADYTM3Zso8bV_8yFyx1-ATbL5AgkKBjvWWR4AsoZUNuLvFe1bQ@mail.gmail.com>
 <20150514192125.GU24269@saruman.tx.rr.com>
 <CADYTM3bbEAVefFZtivJf5Z+2Q+1zDZEvNhqE5ytsOxDX7hjbdA@mail.gmail.com>
 <20150514192946.GV24269@saruman.tx.rr.com>
 <CADYTM3Zk2iD8YMj75CoLJn=4kpoXoXEKUWj2QzdXKGCJjtfG2A@mail.gmail.com>
 <CADYTM3a1QWnec1D=wT=fgZ-RCXAx_qZYYoFg5gWOy0yT4vovHA@mail.gmail.com>
 <20150514212653.GC3338@piout.net>
 <CADYTM3baVqoEBdWoQb5JFyGR2_GKm1FHMYWST1YkZV=m=ZdycQ@mail.gmail.com>
 <20150526145118.GD26599@saruman.tx.rr.com>
 <20150527094205.GO3199@piout.net>
 <5594E56B.3040200@free-electrons.com>
Message-ID: <CADYTM3ZF5m++N1NqmOJoH5agbYrzpvSbLnuLVgttxwzdzwmGwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 2, 2015 at 2:16 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Felipe,
>
> On 27/05/2015 11:42, Alexandre Belloni wrote:
>> Hi,
>>
>> On 26/05/2015 at 09:51:18 -0500, Felipe Balbi wrote :
>>> On Thu, May 14, 2015 at 04:36:33PM -0500, Bin Liu wrote:
>>>> Alexandre,
>>>>
>>>> On Thu, May 14, 2015 at 4:26 PM, Alexandre Belloni
>>>> <alexandre.belloni@free-electrons.com> wrote:
>>>>> On 14/05/2015 at 16:16:12 -0500, Bin Liu wrote :
>>>>>> I think I found the root cause of the problem: board design issue - I
>>>>>> bet the custom board has too much cap on VBUS line. It should be <
>>>>>> 10uF.
>>>>>>
>>>>>
>>>>> We have a custom board that exhibits the issue but it only has a 100nF
>>>>> cap on VBUS.
>>>>
>>>> Have you measured the VBUS discharging? Is there any way to share your
>>>> schematics?
>>>
>>> Alexandre, any further comments ?
>>>
>>
>> Yeah, I have just got more info.
>>
>> This is the relevant part of the schematic:
>> http://free-electrons.com/~alexandre/usb.png
>>
>> The total VBUS capacitance is 200nF and the USB0 pins are connected
>> directly to the AM3358 pins. U1 is actually not fitted.
>>
>> We didn't measure VBUS discharging but we observe the OTG pin sensing
>> stops when plugging an OTG cable without any device.
>
> Do you have any news about this topic?
>
>
> Is there something else that we can do to help solving this issue?

In the case of CONFIG_USB_MUSB_DUAL_ROLE=y and dr_mode=otg, how is the
gadget driver configured? It has to be a module not built-in.

Regards,
-Bin.

>
>
> Thanks,
>
> Gregory
>
>
> --
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
