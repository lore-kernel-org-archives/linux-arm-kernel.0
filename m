From: gsi@denx.de (Gerhard Sittig)
Date: Tue, 17 Sep 2013 18:49:35 +0200
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130917150548.GE14747@book.gsilab.sittig.org>
References: <20130912205644.GW29403@sirena.org.uk>
 <52329AD3.2050608@freescale.com>
 <20130913102127.GD29403@sirena.org.uk>
 <52366F97.5030402@freescale.com>
 <20130916101912.GY29403@sirena.org.uk>
 <5236DD17.5090203@freescale.com>
 <20130916110634.GC29403@sirena.org.uk>
 <5237BB01.3080700@freescale.com>
 <20130917105142.GO21013@sirena.org.uk>
 <20130917150548.GE14747@book.gsilab.sittig.org>
Message-ID: <20130917164935.GG14747@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 17:05 +0200, Gerhard Sittig wrote:
> 
> I liked the S25F datasheet that was referenced here recently,
> it's useful for the discussion that is going on here.  I liked
> the "Serial Peripheral Interface with Multi-I/O" subtitle, which
> suggests that SPI gets enhanced while nothing of it is specific
> to flash chips.  And I liked the sequence diagrams for their
> overview or introduction nature, which you can compare to the SPI
> message submission API in the Linux kernel which connects SPI
> slave drivers and SPI controller drivers.

noticed that I should have provided the URL so those interested
need not search in the thread

www.spansion.com/Support/Datasheets/S25FL128S_256S_00.pdf

> The datasheet had "block diagrams" (section 3.16) [ ... ]
> And the datasheet had "sequence diagrams" (section 4.2.1) [ ... ]


and the relevant design items for the SPI subsystem are:
- express those "phases" of communicating a flash chip related
  "command" in terms of SPI message submission data structures
  (spi_message, spi_transfer)
- make new SPI master drivers support the optional data rate,
  multi-line transfer, dummy bit times, etc features _if_ their
  controller hardware supports them
- announce support of these optional features such that slave
  drivers can query them
- make SPI slave drivers (specifically SPI attached MTD, i.e.
  m25p80) map their flash access operations to respective SPI
  transactions, by introducing an appropriate translation helper

and keep all of the "enhanced modes of SPI communication"
independent from their motivation by and use in flash chip
drivers

and keep internals of one specific flash chip instruction set out
of the SPI transport layer


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
