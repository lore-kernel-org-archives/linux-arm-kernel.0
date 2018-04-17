From: robertcnelson@gmail.com (Robert Nelson)
Date: Mon, 16 Apr 2018 20:14:57 -0500
Subject: [PATCH v2] ARM: dts: Add am335x-pocketbeagle
In-Reply-To: <6A6A9948-48C5-453E-A84F-8B8CA2C00D88@gmail.com>
References: <20180416220828.19338-1-robertcnelson@gmail.com>
 <6A6A9948-48C5-453E-A84F-8B8CA2C00D88@gmail.com>
Message-ID: <CAOCHtYjo=HhGxqFrte5TPo1-UQvwyGHJHMjfZ7HaLCtsjOOhvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 5:27 PM, Jason Kridner <jkridner@gmail.com> wrote:
>
>
>> On Apr 16, 2018, at 6:08 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
>>
>> PocketBeagle is an ultra-tiny-yet-complete open-source USB-key-fob computer.
>>
>> This board can be indentified by the BPxx value after A335BNLT (BBB)
>> in the at24 eeprom:
>> BPxx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 50 30 30 |.U3.A335BNLTBP00|]
>
> The EEPROM value isn?t right. We made it PBGL instead of using BNLT.

Thanks Jason,

Yeah I must have got distracted and coped the one off "PocketBone"
value, in v3 i have it changed to:

+This board family can be indentified by the A335PBGL in the at24 eeprom:
+A2: [aa 55 33 ee 41 33 33 35  50 42 47 4c 30 30 41 32 |.U3.A335PBGL00A2|]


> Is there anything preventing the PRU and GPIO pins from being defined? I guess the GPIO pins might not be exposed through SYSFS due to lack of upstream drivers, but could the pinmux at least be set?

Yeah, we could add those default pinmux's too like I did for spi, (we
use a spidev node, but that can't go mainline)

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
