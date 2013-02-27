From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed, 27 Feb 2013 11:51:53 -0600
Subject: [PATCH Resend v5 00/16] spi/spi-atmel: add dmaengine support for
 atmel spi controller and to test the device tree support
In-Reply-To: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
References: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <CAOCHtYhQsqhf1aBzh2giACMaeE0DXkcZm8qJ73rqn6njFcCaSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 6:34 PM, Wenyou Yang <wenyou.yang@atmel.com> wrote:
> Hi All,
>
> This set of patches is to add dmaengine support for atmel spi and to test device tree support.
>
> The work is based on Nicolas and Richard's work.
>
> Because the Atmel DMA device tree support hasn't on mainline, to at91sam9x5ek and at91sam9n12ek
> with dma support, it doesn't work on the dmaengine mode, only on PIO mode so far.
>
> It has been tested as below:
>  1./tested on v3.8, by using mtd utils, "mount", "umount" and "cp" commands.
>  2./tested on "spi/next" git tree after removing commit "spi: make sure all transfer has proper speed set".
>  3./tested by using Documentation/spi/spidev_test.c on "/dev/spidev".
>  4./tested on on at91sam9x5ek, at91sam9m10g45ek, at91sam9263ek and at91sam9g20ek boards

Hi Wenyou,

Is this patchset missing another enablement patch? With v3.8.0 on the
at91sam9g35ek (device tree boot) I'm getting..

debian at arm:~$ dmesg | grep -i spi
[    0.890625] atmel_spi f0000000.spi: version: 0x212
[    0.890625] atmel_spi f0000000.spi: DMA channel not available,
unable to use SPI
[    0.898437] atmel_spi f0000000.spi: Atmel SPI Controller using PIO only
[    0.906250] atmel_spi f0000000.spi: Atmel SPI Controller at
0xf0000000 (irq 30)
[    0.914062] atmel_spi f0000000.spi: master is unqueued, this is deprecated
debian at arm:~$ ls /dev/spi*
ls: cannot access /dev/spi*: No such file or directory

.config for reference, encase i missed something obvious:
https://github.com/RobertCNelson/armv5_devel/blob/v3.8.x-at91/patches/defconfig

CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

CONFIG_SPI_ATMEL=y

CONFIG_SPI_SPIDEV=y

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
