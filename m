From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 23 Jan 2011 16:35:06 +0200
Subject: colibri-pxa300 USB patch
In-Reply-To: <AANLkTinMGXF=0k2qiU0qif695KoTGyz3cH6gSbZJ7Hfc@mail.gmail.com>
References: <AANLkTikN2bqq7khp4mvqmfH=14Gzewd1da=2OGLJcnTZ@mail.gmail.com>	<201101231212.27627.marek.vasut@gmail.com>	<AANLkTinN7TyOaj9=-8eXtrJPzf=iZdvqJOBMwyS=9D=c@mail.gmail.com>	<201101231408.19511.marek.vasut@gmail.com>
	<AANLkTinMGXF=0k2qiU0qif695KoTGyz3cH6gSbZJ7Hfc@mail.gmail.com>
Message-ID: <4D3C3C9A.3090309@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

On 01/23/11 16:22, Bj?rn Forsman wrote:

> 2011/1/23 Marek Vasut <marek.vasut@gmail.com>:
>> On Sunday 23 January 2011 13:49:41 Bj?rn Forsman wrote:
>>> 2011/1/23 Marek Vasut <marek.vasut@gmail.com>:
> [snip git trees and workflow stuff]
>
>>>> Hi,
>>>>
>>>> just curious, this should make the TOP usb port or the BOTTOM one
>>>> working?
>>> TOP port.
>> Maybe it really cannot be used with pxa310 colibri. But then I think it worked
>> on their wince crap.
> I have a Colibri PXA310 module with WinCE preflashed. I will test what
> USB ports it supports on monday.
>
>> btw. please keep the LAKML CCed.
>>
>>>> I got the TOP one operational, but no luck with the bottom one on pxa310
>>>> colibri. Checking the colibri datasheet, there's an SMSC USB3329 chip
>>>> attached to usb port3 ... well did you have any luck getting the BOTTOM
>>>> port working ? Maybe with some further patching?
>>> No luck with bottom port for me. Do you have a link to that datasheet?
>> Quick google shows some 10-page thing ... that's it.
> Think I found it (20 pages). It says:
>
> Colibri PXA300 only:
>   - USB 2.0 device (requires external UTMI chip)
> Colibri PXA310 only:
>   - Built-In USB 2.0 device transceiver
>
>
> And further down:
>
> 1.4.1 Colibri PXA310 only:
> Wolfson WM9715L Audio-Codec
> http://www.wolfsonmicro.com/
>
> SMSC ULPI Transceiver USB3329
> http://www.smsc.com/

This one is most likely the port2 transceiver (OTG),

> Fairchild USB Transceiver USB1T1105
> http://www.fairchildsemi.com/

and this one should be the port3 transceiver (Host).

>
> So, couldn't it also be the Fairchild tranceiver? Or both??
>
> Best regards,
> Bj?rn Forsman
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Regards,
Igor.
