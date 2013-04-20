From: vkale@apm.com (Vinayak Kale)
Date: Sat, 20 Apr 2013 14:49:37 +0530
Subject: [PATCH 4/4] arm64: Add initial DTS for APM X-Gene Storm SOC and
 APM Mustang board
In-Reply-To: <4355208.ttMnntCBET@wuerfel>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
 <1366442131-26094-5-git-send-email-vkale@apm.com>
 <4355208.ttMnntCBET@wuerfel>
Message-ID: <CAPrCYkcVUn7ZtUc1zc-Wq47q4OgaPvO9rNRkHgCxN+ea_ZjZqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 20, 2013 at 1:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 20 April 2013 12:45:31 Vinayak Kale wrote:
>> This patch adds initial DTS files required for APM Mustang board.
>>
>> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>
> Looks ok, just one comment
>
>> +     soc {
>> +             compatible = "simple-bus";
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             ranges;
>> +
>> +             serial0: uart0 at 1c020000 {
>> +                     device_type = "serial";
>> +                     compatible = "ns16550";
>> +                     reg = <0 0x1c020000 0x0 0x1000>;
>> +                     reg-shift = <2>;
>> +                     clock-frequency = <10000000>; /* Updated by bootloader */
>> +                     interrupt-parent = <&gic>;
>> +                     interrupts = <0x0 0x4c 0x4>;
>> +             };
>> +     };
>> +};
>
> The standard name for the uart is "serial", not "uart0". Please never use
> numbers in the name part of the device, the idea is that you have the
> same name for each device of the same kind and ambiguate them by the
> address part or using a label. If you have multiple uarts on the SoC,
> I would also recommend listing all of them here, and marking them
> as status="disabled", and then have an entry in the board specific
> .dts file to mark the ones that are connected to the outside like
>
> &serial0 {
>         status = enabled;
> };
Okay.
>
>         Arnd
Thanks
-Vinayak
