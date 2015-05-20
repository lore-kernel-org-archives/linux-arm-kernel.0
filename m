From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Wed, 20 May 2015 15:26:17 +0200
Subject: [BUG] at91: serial: is it using DMA?
Message-ID: <555C8B79.4030900@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
I discovered problem with serial driver in kernel 4.0.4 on at91sam9g25 at 400MHz.
When I want receive frames on UART at 115200kb/s I get many errors caused by loss of some bytes.
These errors were there if no DMA was used in previous version.
Dmesg says DMA us used:
[    0.000000] Linux version 4.0.4_cpm9g25 (prchal at prchal) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #5 
PREEMPT Wed May 20 12:19:37 CEST 2015
...
[   16.090090] atmel_usart f801c000.serial: using dma0chan4 for rx DMA transfers
[   16.105105] atmel_usart f801c000.serial: using dma0chan5 for tx DMA transfers

In 3.18.13 it works properly and dmesg says the same:
[    0.000000] Linux version 3.18.13_cpm9g25 (prchal at prchal) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #3 
PREEMPT Wed May 20 14:29:26 CEST 2015
...
[   14.936936] atmel_usart f801c000.serial: using dma0chan4 for rx DMA transfers
[   14.954954] atmel_usart f801c000.serial: using dma0chan5 for tx DMA transfers

I made diff of drivers/tty/serial/atmel_serial.c and I see many changes in function atmel_rx_from_dma witch I don't 
understand. Could it bee there?
All other DMAs work fine.

Jiri
