From: fkan@apm.com (Feng Kan)
Date: Fri, 14 Nov 2014 11:17:38 -0800
Subject: [PATCH V2 1/7] arm64: dts: Add APM X-Gene USB DTS node
In-Reply-To: <2126031.OOHBs2pzVu@wuerfel>
References: <1415924401-3013-1-git-send-email-fkan@apm.com>
 <1415924401-3013-2-git-send-email-fkan@apm.com>
 <2126031.OOHBs2pzVu@wuerfel>
Message-ID: <CAL85gmCXBFCs6dNQXDLh4HAgZ4SN7Wwnon_D3a4q_Rq3oz-Vvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 7:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 13 November 2014 16:19:55 Feng Kan wrote:
>>
>> +               usb0: dwusb at 19000000 {
>> +                       status = "disabled";
>> +                       compatible = "xhci-platform";
>> +                       reg =  <0x0 0x19000000 0x0 0x100000>;
>> +                       interrupts = <0x0 0x89 0x4>;
>> +                       dma-coherent;
>> +               };
>> +
>> +               usb1: dwusb at 19800000 {
>> +                       status = "disabled";
>> +                       compatible = "xhci-platform";
>> +                       reg =  <0x0 0x19800000 0x0 0x100000>;
>> +                       interrupts = <0x0 0x8a 0x4>;
>> +                       dma-coherent;
>> +               };
>>
>
> Call the nodes 'usb', not 'dwusb'.
This was a deliberate change on our part to make sure backward
compatibility with a older bootloader.

> Should these be 'status="disabled"', or
> do you expect every machine to have both connected?
Not all platform has both enabled at this point. Not enabling them
would allow us to save some power
if the IP is not used.
>
>         Arnd
