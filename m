From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Fri, 16 Oct 2015 12:44:46 -0300
Subject: [PATCH 0/2] Add support for NXP LPC18xx EEPROM using nvmem
In-Reply-To: <1445004426-6271-1-git-send-email-ariel@vanguardiasur.com.ar>
References: <1445004426-6271-1-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <CAAEAJfD58JMZ0veB4TVE8QfZ5OUqO7=q7Lk5wBME6+mFF=_dxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2015 at 11:07, Ariel D'Alessandro
<ariel@vanguardiasur.com.ar> wrote:
> This patch series adds support for NXP LPC18xx EEPROM memory found in
> NXP LPC SoCs family, which includes LPC18xx/LPC43xx. Other SoCs in

Is the EEPROM available on all LPC18xx/LPC43xx devices?
IIRC, just a subset supports it.

> that family may share the same watchdog hardware.
>

s/watchdog/eeprom

> This patchset is based on tag next-20151013 of the linux-next
> repository. It has been successfully tested on a LPC4337 CIAA-NXP
> Board.
>
> EEPROM notes:
> ------------
>
> EEPROM size is 16384 bytes and it can be entirely read and
> written/erased with 1 word (4 bytes) granularity. The last page
> (128 bytes) contains the EEPROM initialization data and is not writable.
>
> Erase/program time is less than 3ms. The EEPROM device requires a
> ~1500 kHz clock (min 800 kHz, max 1600 kHz) that is generated dividing
> the system bus clock by the division factor, contained in the divider
> register (minus 1 encoded).
>
> Thanks,
>
> Ariel D'Alessandro (2):
>   nvmem: NXP LPC18xx EEPROM memory NVMEM driver
>   DT: nvmem: Add NXP LPC18xx EEPROM memory binding documentation
>

Can you please add a patch for the lpc18xx_defconfig and for devicetree files?

Thanks!
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
