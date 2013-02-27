From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 27 Feb 2013 20:47:14 +0100
Subject: [PATCH Resend v5 00/16] spi/spi-atmel: add dmaengine support for
 atmel spi controller and to test the device tree support
In-Reply-To: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
References: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <CAGhQ9VymJxSRxDUUqzFgkOaY5tjmHe5kmeDtsrYQwMUwAAi0Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2013 01:34, Wenyou Yang <wenyou.yang@atmel.com> wrote:
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
>
> It is based on v3.8.

Did a quick test on at91rm9200 and it still works:
(DataFlash on SPI CS0 in HW mode)

[    1.100000] atmel_spi fffe0000.spi: version: 0x0
[    1.120000] atmel_spi fffe0000.spi: Atmel SPI Controller at
0xfffe0000 (irq 23)
[    1.130000] atmel_spi fffe0000.spi: master is unqueued, this is deprecated
[    1.130000] mtd_dataflash spi32766.0: AT45DB642x (8448 KBytes)
pagesize 1056 bytes (OTP)

so;
Tested-by: Joachim Eastwood <manabian@gmail.com>

regards
Joachim Eastwood
