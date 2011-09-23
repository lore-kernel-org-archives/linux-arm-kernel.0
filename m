From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Sep 2011 20:53:33 +0100
Subject: Identifying Primecells
In-Reply-To: <CAKON4OxHwjrw-dhH2qvXopqUqmKSx2TCPgW4eVHF9dmQO4=Cvw@mail.gmail.com>
References: <CAKON4OxqqBh4xFLwiMZzsGrnoG8erQ0hMFX-_VA-EDMvdNkvQQ@mail.gmail.com>
	<4E7C7FA2.30404@gmail.com>
	<CAKON4OzGEo+XvcNg=mzp3jhq3d3m7Z9bvZTSVCNLNjZ=KYbNBQ@mail.gmail.com>
	<4E7C89FC.4090209@gmail.com>
	<CAKON4OxZPFFL5NAgxLPRw2xxnS=v7iVWtQSSLcUJWfOYh4yfjA@mail.gmail.com>
	<1316787049.4611.920.camel@hornet.cambridge.arm.com>
	<CAKON4OxHwjrw-dhH2qvXopqUqmKSx2TCPgW4eVHF9dmQO4=Cvw@mail.gmail.com>
Message-ID: <20110923195333.GR17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 10:17:32AM -0400, jonsmirl at gmail.com wrote:
> My registers don't seem to match up with the pl011 documentation...
> 
> Table 437. Register overview: UART (register base address 0x1500 1000)
> Name	R/W	Address	Offset		Description
> RBR	R	0x000	Receiver Buffer Register
> THR	W	0x000	Transmitter Holding Register
> DLL	R/W	0x000	Divisor Latch LSB
> DLM	R/W	0x004	Divisor Latch MSB
> IER	R/W	0x004	Interrupt	Enable Register
> IIR	R	0x008	Interrupt	Identification Register
> FCR	W	0x008	FIFO Control Register
> LCR	R/W	0x00C	Line	 Control Register
> MCR	R/W	0x010	Modem Control Register
> LSR	R	0x014	Line Status Register
> MSR	R	0x018	Modem Status Register
> SCR	R/W	0x01C			Scratch Register

This looks like an 8250 like clone.  You might be about to get away
with using a platform device for the 8250 driver specifying an io
shift of 2, base address 0x15001000.

What worries me is the extra registers below, and whether they need to
be programmed to something at runtime (rather than just being able to
rely on the standard 8250 register set.)

> -	-	0x020			Reserved
> ICR	R/W	0x024	IrDA	 Control Register
> FDR	R/W	0x028	Fractional Divider Register
> -	-	0x02C	Reserved
> POP	W	0x030	NHP Pop Register
> MODE	R/W	0x034	NHP Mode Selection Register
> -	-	0x038-0xFD4	Reserved
> INTCE	W	0xFD8	Interrupt	Clear Enable Register
> INTSE	W	0xFDC	Interrupt	Set Enable Register
> INTS	R	0xFE0	Interrupt	Status Register
> INTE	R	0xFE4	Interrupt	Enable Register
