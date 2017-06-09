From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Jun 2017 20:55:26 +0200
Subject: [PATCH] ARM: at91: fix at91_suspend_entering_slow_clock link error
In-Reply-To: <20170609114416.6ru5emtqmbubgmzd@piout.net>
References: <20170609101821.2776168-1-arnd@arndb.de>
 <20170609114416.6ru5emtqmbubgmzd@piout.net>
Message-ID: <CAK8P3a2dp-phi1vZQhq_97vP7-on=mF6i7wdL3H5kf82aoR4VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 1:44 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 09/06/2017 at 12:18:02 +0200, Arnd Bergmann wrote:
>> When CONFIG_ARCH_AT91 is enabled, but none of the specific SoC support
>> is in use, some at91 specific drivers fail to link:
>>
>> drivers/tty/serial/atmel_serial.o: In function `atmel_serial_suspend':
>> atmel_serial.c:(.text.atmel_serial_suspend+0x1e): undefined reference to `at91_suspend_entering_slow_clock'
>> drivers/usb/host/ohci-at91.o: In function `ohci_hcd_at91_drv_suspend':
>> ohci-at91.c:(.text.ohci_hcd_at91_drv_suspend+0x12): undefined reference to `at91_suspend_entering_slow_clock'
>> drivers/usb/gadget/udc/at91_udc.o: In function `at91udc_suspend':
>> at91_udc.c:(.text.at91udc_suspend+0x26): undefined reference to `at91_suspend_entering_slow_clock'
>>
>
> How you present it makes me think, that this was present for a while,
> even before samv7 support was added. Am I wrong?

I only ran into the problem after samv7 support was added. Before that,
pm.o was always built-in when CONFIG_AT91 was set, even when none
of the specific platforms got enabled.

       Arnd
