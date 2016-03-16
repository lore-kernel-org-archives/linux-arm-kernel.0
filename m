From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 16 Mar 2016 21:27:16 +0300
Subject: [PATCH 3/5] ARM: davinci: da8xx: add cfgchip2 to resources
In-Reply-To: <56E9A456.2000204@cogentembedded.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
 <1458081473-8223-3-git-send-email-david@lechnology.com>
 <56E8906E.7070800@cogentembedded.com> <56E8D720.7000508@lechnology.com>
 <56E8E7C7.70901@lechnology.com> <56E99A16.9020709@cogentembedded.com>
 <56E9A282.7030103@lechnology.com> <56E9A456.2000204@cogentembedded.com>
Message-ID: <56E9A584.9040609@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2016 09:22 PM, Sergei Shtylyov wrote:

>>>> Also, I am not finding any existing data structure to pass the musb
>>>> set_mode
>>>> function to the phy in either usb_phy or usb_otg. Setting the mode
>>>> (host/peripheral/otg) is done in the same PHY register, so it seems
>>>> like it
>>>> should be implemented in the new phy driver as well.
>>>
>>>     Perhaps we'd have to sacrifice that functionality...
>>
>> The device I am working on (LEGO MINDSTORMS EV3) has the port wired as
>> peripheral only, so I don't think leaving this out is an option. Leaving it in
>> OTG mode doesn't work because the required electrical connections are just not
>> there.
>
>     The set_mode() method doesn't have anything to do with the predefined
> roles. What CFGCHIP2 setting do is to override the ID input (and also the VBUS
> level comparator). This is not required for the normal functioning of either
> host or peripheral AFAIR.

   Or at least it wasn't when I last looked. Now it does... :-/

> [...]

MBR, Sergei
