From: mensch0815@googlemail.com (matthias)
Date: Tue, 27 Oct 2009 10:44:01 +0100
Subject: spi doubt on AP7000
Message-ID: <3e4778d50910270244x3e9a1275mab7c4fe7812b5d10@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,


I develop on a custom board which makes heavy use of spi transfers on
both spi modules (spi0 and spi1) to read sensor data. Kernel version
is 2.6.25.10.
I observe some weird spi controller errors: if I communicate with more
spi slaves on spi bus 1, I get an error on spi bus 0.
In drivers/spi/atmel_spi.c:
dev_warn(master->dev.parent, "fifo overrun (%u/%u remaining)\n",
spi_readl(as, TCR), spi_readl(as, RCR));

This happens due to doubled writing of RDR memory of the peripheral
dma controller (pdc), although both spi controllers have different pdc
memory regiones assigned (see at32ap700x.c for details).
Does anyone can explain me why transfer amount of spi 1 influences spi 0?
Any suggestions how I can get rid of this error apart from minimizing
max_speed_hz of the attached spi_device(s)?
Regards,
Matthias


-- 
motzblog.wordpress.com
