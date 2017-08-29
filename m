From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 29 Aug 2017 09:40:06 +0200
Subject: [PATCH 1/2] mtd: spi-nor: add an option to force 3byte adressing
 mode
In-Reply-To: <37be90e4-c43b-26f8-7551-45ab107e2a4d@gmail.com>
References: <1503954854-30963-1-git-send-email-mw@semihalf.com>
 <1503954854-30963-2-git-send-email-mw@semihalf.com>
 <37be90e4-c43b-26f8-7551-45ab107e2a4d@gmail.com>
Message-ID: <CAPv3WKcL4wNseCrG5=2q51=6Xs1jERoB=50ar6T58nDK8aM9vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

2017-08-29 1:24 GMT+02:00 Marek Vasut <marek.vasut@gmail.com>:
> On 08/28/2017 11:14 PM, Marcin Wojtas wrote:
>> Hitherto code set 4B addressing mode for all SPI flashes whose
>> size exceeds 16MB. However, changing the default 3B access
>> in some cases may be harmful - it may happen that the Boot ROM
>> is not capable of handling non-default state of the SPI NOR
>> (e.g. after soft reset).
>
> No, this happens when your hardware is broken and does NOT reset the
> flash while reseting the CPU as well. If the flash is in some funny
> state (ie. middle of page program or erase cycle, which takes long OR
> 4byte addressing mode) and the CPU resets , then if the SPI NOR is not
> reset, your system will still get stuck . You need to fix your hardware
> such that you use the reset output of your CPU to detect when the CPU
> restarted and add logic to reset your storage as well.
>
> This stuff below is a poor workaround and has it's known problems which
> can only be solved by fixing the hardware. This problem keeps coming up
> repeatedly, just skim through the Linux MTD and U-Boot lists for other
> victims of bad HW design. I don't think I want to see it in the kernel
> as that would motivate people to use it rather than fixing their HW .
>

Understood. I just only got impression that attempts to overcome the
HW design faults in terms of keeping SPI NOR default state during boot
can be added - introducing SPI_NOR_4B_OPCODES seems to have no other
reason, however it favors only a group of devices that support it.

Best regards,
Marcin
