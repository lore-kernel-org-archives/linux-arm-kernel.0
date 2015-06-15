From: cornogle@googlemail.com (Christian Hartmann)
Date: Mon, 15 Jun 2015 13:28:31 +0200
Subject: Fwd: [PATCH spi-pxa2xx.c 1/1] : fix spi init of WM510205 codec via
 ACPI, the chip hangs on chipselect 1
In-Reply-To: <CAKor6TezwST=8qR9wuAojvLfxtzrDw+W3vDMP0i_GR+W1eijuQ@mail.gmail.com>
References: <CAKor6TezwST=8qR9wuAojvLfxtzrDw+W3vDMP0i_GR+W1eijuQ@mail.gmail.com>
Message-ID: <CAKor6TcAA-1BSfqF53hyv7D_1qS3+435xJgnp=BmHrmrw+qLPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello list,

I am sorry, I have forgotten to take you ('this list' ) in CC.
So I forward this mail now and wait for some feedback or an ack or nack...

cheers
chris



---------- Forwarded message ----------
From: Christian Hartmann <cornogle@googlemail.com>
Date: 2015-06-11 15:04 GMT+02:00
Subject: [PATCH spi-pxa2xx.c 1/1] : fix spi init of WM510205 codec via
ACPI, the chip hangs on chipselect 1
To: patches at opensource.wolfsonmicro.com
Cc: alsa-devel at alsa-project.org


Hello,

I have one patch that enables the spi initialization of the WM510205 audio codec
Without the patch, this message indicates that the codec chip fails
with the current chipselect number in spi-pxa2xx:

[ 0.296256] pxa2xx-spi 80860F0E:00: cs1 >= max 1
[ 0.296270] spi_master spi32766: failed to add SPI device
WM510205:00 from ACPI

So raise num_chipselect by one to enable the codec. The WM510202 is on
chipselect = 1.

With the patch applied I got in dmesg now:

[    6.056829] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    6.067035] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    6.067214] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    6.067221] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    6.067287] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00

would be nice to hear some feedback or comments about this patch.

Notice: Thats my first attempt to make the codec chip via ACPI
working on Linux systems and some other patches are needed to let the
codec work together with the intel_sst_acpi driver. Currently I am
trying to write the also needed machine driver which binds to this
codec chip.
But I can need help from others too, cause I am not so familiar with
the Intel SST ACPI stuff and the baytrail code itself, nor with the
arizona stuff...

cheers
Chris
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-spi-pxa2xx-raise-num_chipselect-for-this-platform-da.patch
Type: text/x-patch
Size: 864 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150615/d0c817dc/attachment.bin>
