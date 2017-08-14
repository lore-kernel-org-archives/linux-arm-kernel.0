From: aik@ozlabs.ru (Alexey Kardashevskiy)
Date: Tue, 15 Aug 2017 01:07:29 +1000
Subject: SUN8I_EMAC driver wanted (for Orange Pi)
In-Reply-To: <20170814133930.GA5324@Red>
References: <3792055e-d56f-e722-d9f8-519b46fd73dd@ozlabs.ru>
 <20170813154920.GA31401@lunn.ch>
 <92615469-ba27-9c93-9915-872de3c42462@ozlabs.ru>
 <76df0ea9-e875-c1bc-97ab-670e917ecfcb@ozlabs.ru> <20170814133930.GA5324@Red>
Message-ID: <766985d8-75ee-f89a-732b-1c2193aa100d@ozlabs.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/17 23:39, Corentin Labbe wrote:
> On Mon, Aug 14, 2017 at 11:21:05PM +1000, Alexey Kardashevskiy wrote:
>> On 14/08/17 10:54, Alexey Kardashevskiy wrote:
>>> On 14/08/17 01:49, Andrew Lunn wrote:
>>>> On Mon, Aug 14, 2017 at 01:09:15AM +1000, Alexey Kardashevskiy wrote:
>>>>> Hi!
>>>>>
>>>>> I have been using v4.8 with some driver I found somewhere. Ported to v4.13,
>>>>> it does not work anymore and I wonder if anyone has an idea where to get a
>>>>> working one from?
>>>>
>>>> Hi Alexey
>>>>
>>>> A driver for this was added to Linux May 31st. Try 4.13-rcX enabling
>>>> DWMAC_SUN8I.
>>>
>>> Thanks, works nicely!
>>
>>
>> Aaand it stopped with the only message in dmesg (I was trying to enable
>> video on that pi but I removed DRM and everything and still seeing this):
>>
>>
>> 114 [    0.816334] dwmac-sun8i 1c30000.ethernet: MAC IRQ configuration
>> information not found
>>
>> eth0 does not appear in the system, what am I missing now? Thanks!
>>
> 
> Hello
> 
> Do you use the maintline dtb or an external one ?
> The error message seems to say that you do not use the right DTB.


Yes, that was it, I was under impression I am not changing it but it was
overwritten by the pizero's one. All good now, thanks for the hint.

By any chance, do you have a webpage link handy about making pi-pc video
work? :) I found quite many howtos, all outdated, copied
script.bin.OPI-PC_1080p60_dvi to /boot/script.bin but I am pretty sure I am
missing the kernel support as there is only "fbcon" in /sys/class/graphics/
CONFIG_DRM_MALI_DISPLAY and CONFIG_HDMI are enabled, what else?


-- 
Alexey
