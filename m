From: b32955@freescale.com (Huang Shijie)
Date: Wed, 11 Sep 2013 18:54:55 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130911104126.GN29403@sirena.org.uk>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk> <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk> <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk>
Message-ID: <52304BFF.4060007@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?09?11? 18:41, Mark Brown ??:
> So why does the SPI driver have references to the opcodes in it?
I admit that the Freescale's quadspi controller is very special
(it is designed too coupled with the SPI Nor FLASH),
it is driven by the LUT registers.

I just quote the comment from the patch 1:


-------------------------------------------------------------
(2) The definition of the LUT register shows below:

---------------------------------------------------
| INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
---------------------------------------------------

There are several types of INSTRx, such as:
CMD : the SPI NOR command.
ADDR : the address for the SPI NOR command.
DUMMY : the dummy cycles needed by the SPI NOR command.
....
-------------------------------------------------------------------

The LUT registers needs to be filled with the SPI NOR command, such
Fast-read/Quad-read.
So the Quadspi driver needs to know the spi commands, and that's why the
SPI driver has
references to the spi command opcodes.

 
thanks
Huang Shijie
