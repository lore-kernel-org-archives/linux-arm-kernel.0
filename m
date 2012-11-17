From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 17 Nov 2012 16:32:33 +0100
Subject: arm: at91: mach header cleanup
In-Reply-To: <201211122147.36510.arnd@arndb.de>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <201211122147.36510.arnd@arndb.de>
Message-ID: <CAGhQ9VzCVqVPCDxgeaisPKscnpvqy4JSSWnVUzQQQG-AzD4hbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2012 22:47, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 07 November 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:
>>
>>   Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)
>>
>> are available in the git repository at:
>>
>>   git://github.com/at91linux/linux-at91.git tags/for-3.8-at91_header_clean
>>
>> for you to fetch changes up to 75984df05d86956541795f01e62d7dc67bc522fd:
>>
>>   arm: at91: move at91rm9200 rtc header in drivers/rtc (2012-11-06 20:30:52 +0800)
>>
>> ----------------------------------------------------------------
>> arm: at91: mach header cleanup
>>
>> This first patch serie start the cleanup of the header in mach
>> by moving all the platform data to include/linux/platform_data
>>
>> and move the board header and drivers header next to them
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>
> Hi Jean-Christophe,
>
> Sorry for the delay, I've pulled it now into the next/cleanup branch.
>

Hi,

The changes to atmel_serial break compile on AVR32 with:
  drivers/tty/serial/atmel_serial.c:162: error: 'ATMEL_MAX_UART'
undeclared here (not in a function)
  make[3]: *** [drivers/tty/serial/atmel_serial.o] Error 1

This is because AVR32 defined ATMEL_MAX_UART in mach/board.h.
I wonder why this didn't break on AT91, though. On AT91 it's defined in
mach/hardware.h but I can't see that file being included anywhere here.

Unsure what the best fix is. Maybe we could move ATMEL_MAX_UART into
linux/platform_data/atmel.h.

regards
Joachim Eastwood
