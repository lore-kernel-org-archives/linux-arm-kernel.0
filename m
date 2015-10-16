From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Fri, 16 Oct 2015 15:49:01 -0300
Subject: [PATCH 0/2] Add support for NXP LPC18xx EEPROM using nvmem
In-Reply-To: <CAAEAJfD58JMZ0veB4TVE8QfZ5OUqO7=q7Lk5wBME6+mFF=_dxg@mail.gmail.com>
References: <1445004426-6271-1-git-send-email-ariel@vanguardiasur.com.ar>
 <CAAEAJfD58JMZ0veB4TVE8QfZ5OUqO7=q7Lk5wBME6+mFF=_dxg@mail.gmail.com>
Message-ID: <5621469D.2050703@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

El 16/10/15 a las 12:44, Ezequiel Garcia escribi?:
> On 16 October 2015 at 11:07, Ariel D'Alessandro
> <ariel@vanguardiasur.com.ar> wrote:
>> This patch series adds support for NXP LPC18xx EEPROM memory found in
>> NXP LPC SoCs family, which includes LPC18xx/LPC43xx. Other SoCs in
> 
> Is the EEPROM available on all LPC18xx/LPC43xx devices?
> IIRC, just a subset supports it.

(Answered in another thread.)

> 
>> that family may share the same watchdog hardware.
>>
> 
> s/watchdog/eeprom

Wow, that's what happen when copy/pasting. Will try to be more careful
next time :)

> 
>> This patchset is based on tag next-20151013 of the linux-next
>> repository. It has been successfully tested on a LPC4337 CIAA-NXP
>> Board.
>>
>> EEPROM notes:
>> ------------
>>
>> EEPROM size is 16384 bytes and it can be entirely read and
>> written/erased with 1 word (4 bytes) granularity. The last page
>> (128 bytes) contains the EEPROM initialization data and is not writable.
>>
>> Erase/program time is less than 3ms. The EEPROM device requires a
>> ~1500 kHz clock (min 800 kHz, max 1600 kHz) that is generated dividing
>> the system bus clock by the division factor, contained in the divider
>> register (minus 1 encoded).
>>
>> Thanks,
>>
>> Ariel D'Alessandro (2):
>>   nvmem: NXP LPC18xx EEPROM memory NVMEM driver
>>   DT: nvmem: Add NXP LPC18xx EEPROM memory binding documentation
>>
> 
> Can you please add a patch for the lpc18xx_defconfig and for devicetree files?

Yes, I'll add those in next patchset v2.

Thanks!

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
