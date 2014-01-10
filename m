From: marek.belisko@gmail.com (Belisko Marek)
Date: Fri, 10 Jan 2014 07:55:48 +0100
Subject: 3.13-rc2 phy-twl4030-usb.c - Timeout setting T2 HSUSB PHY DPLL
In-Reply-To: <52CF8455.5090506@ti.com>
References: <CAAfyv37aM6SrpuU9fzKA6GKsWn=To5ANOpG_kSX509NjMjdecA@mail.gmail.com>
 <529F1E89.6080700@ti.com>
 <CAAfyv36sNyEiEHEOKfZWN1xRYLGUt-NW18uhcJbSTWRBA5=2BA@mail.gmail.com>
 <52CE32AB.1050204@ti.com> <52CF8455.5090506@ti.com>
Message-ID: <CAAfyv34ce=V_nheonE0HLGPNEF=Z_Ep-hj64dSuKrRqehNfOCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 10, 2014 at 6:25 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Thursday 09 January 2014 10:54 AM, Roger Quadros wrote:
>> Hi Marek,
>>
>> I have no idea what is happening there. Have you tried using device tree boot?
>> Board file boot support would be dropped eventually.
>>
>> Did you try if I2C read write to the twl4030 device works and all necessary clocks/supplies are
>> present?
>>
>> Kishon, do you know what is causing the USB DPLL failure there?
Issue was fixed. There was in 3.13-rc7 issue with unable to find phy
(phy was twl4030_usb). After that
issue is gone.
>
> Not sure what's causing those failures :-s
>
> -Kishon
>
>>
>> cheers,
>> -roger
>>
>> On 01/09/2014 02:31 AM, Belisko Marek wrote:
>>> Any pointers? Still present in 3.13-rc7.
>>>
>>> On Wed, Dec 4, 2013 at 1:22 PM, Roger Quadros <rogerq@ti.com> wrote:
>>>> +Kishon
>>>>
>>>> On 12/03/2013 11:33 PM, Belisko Marek wrote:
>>>>> Hi,
>>>>>
>>>>> current 3.13-rcX break usb support on gta04 board (similar to
>>>>> beagleboard) when booting via board file.
>>>>>
>>>>> In console we can see messages:
>>>>>  [ 5227.287841] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>>>>> [ 5232.936096] omap_musb_mailbox: musb core is not yet ready
>>>>> [ 5233.958160] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>>>>> [ 5235.058227] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>>>>>
>>>>> Any pointer what could cause that? (in 3.12 usb works fine)
>>>>>
>>>>> BR,
>>>>>
>>>>> marek
>>>>>
>>>>
>>>
>>> BR,
>>>
>>> marek
>>>
>>
>

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
