From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 1 Aug 2016 09:27:12 +0200
Subject: [PATCH 3/3] ehci-platform: add the max clock number to 4
In-Reply-To: <414101470035152@web9j.yandex.ru>
References: <20160731112536.4625-1-icenowy@aosc.xyz>
 <20160731112536.4625-3-icenowy@aosc.xyz> <2477355.hXm3xYUusy@wuerfel>
 <414101470035152@web9j.yandex.ru>
Message-ID: <01a348da-3b26-68a6-9d9f-c37d81b4fd64@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01-08-16 09:05, Icenowy Zheng wrote:
> 			clocks = <&ccu CLK_A64_BUS_OHCI1>,
> 				 <&ccu CLK_A64_BUS_EHCI1>,
> 				 <&ccu CLK_A64_USB_OHCI0>,
> 				 <&ccu CLK_A64_USB_OHCI1>;
>
> On A64, EHCI requires the matched OHCI to work.

Ah, so just like on the H3 (where this also is needed
and not documented).

> And OHCI1 clock requires OHCI0 clock to work.

Hmm, that one is new, can you double check this ?

Regards,

Hans


>
> (But from the SoC's user manual we cannot get any infomation
> about the relationship between OHCI1 clock and OHCI0 clock,
> and in the manual OHCI0 clock is called OTG-OHCI)
>
> 01.08.2016, 15:01, "Arnd Bergmann" <arnd@arndb.de>:
>> On Sunday, July 31, 2016 7:25:36 PM CEST Icenowy Zheng wrote:
>>>  Allwinner A64 EHCI requires 4 clocks to be enabled.
>>>
>>>  Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>>
>> Can you say what those four clocks are?
>>
>> Are you sure that it's not just a case of a clock being
>> incorrectly described in the clk driver, i.e. you reference
>> one clock along with its parent here?
>>
>>         Arnd
