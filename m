From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 23 Sep 2011 10:17:32 -0400
Subject: Identifying Primecells
In-Reply-To: <1316787049.4611.920.camel@hornet.cambridge.arm.com>
References: <CAKON4OxqqBh4xFLwiMZzsGrnoG8erQ0hMFX-_VA-EDMvdNkvQQ@mail.gmail.com>
	<4E7C7FA2.30404@gmail.com>
	<CAKON4OzGEo+XvcNg=mzp3jhq3d3m7Z9bvZTSVCNLNjZ=KYbNBQ@mail.gmail.com>
	<4E7C89FC.4090209@gmail.com>
	<CAKON4OxZPFFL5NAgxLPRw2xxnS=v7iVWtQSSLcUJWfOYh4yfjA@mail.gmail.com>
	<1316787049.4611.920.camel@hornet.cambridge.arm.com>
Message-ID: <CAKON4OxHwjrw-dhH2qvXopqUqmKSx2TCPgW4eVHF9dmQO4=Cvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 10:10 AM, Pawel Moll <pawel.moll@arm.com> wrote:
>> Is peripheral use documented at ARM for the lpc3130? What I don't know
>> is if the peripherals have been modified or replaced with an
>> alternative implementation.
>>
>> So I guess I need to figure out how to read the ID register.
>
> I'm not sure what your problem exactly is, but if you want to know what
> PeriphID for PL011 is, have a look here:
>
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0183g/I18381.html
>
> So if your UART is PL011, reading four 8-bit wide registers at
> * base + 0xfe0
> * base + 0xfe4
> * base + 0xfe8
> * base + 0xfec
> should give you (respectively):
> * 0x11
> * 0x10
> * 0x_4 (_ depends on the cell revision)
> * 0x00
>
> Of course AMBA bus match_id will do this for you so, as I said, I'm not
> sure what the problem is...

My registers don't seem to match up with the pl011 documentation...

Table 437. Register overview: UART (register base address 0x1500 1000)
Name	R/W	Address	Offset		Description
RBR	R	0x000	Receiver Buffer Register
THR	W	0x000	Transmitter Holding Register
DLL	R/W	0x000	Divisor Latch LSB
DLM	R/W	0x004	Divisor Latch MSB
IER	R/W	0x004	Interrupt	Enable Register
IIR	R	0x008	Interrupt	Identification Register
FCR	W	0x008	FIFO Control Register
LCR	R/W	0x00C	Line	 Control Register
MCR	R/W	0x010	Modem Control Register
LSR	R	0x014	Line Status Register
MSR	R	0x018	Modem Status Register
SCR	R/W	0x01C			Scratch Register
-	-	0x020			Reserved
ICR	R/W	0x024	IrDA	 Control Register
FDR	R/W	0x028	Fractional Divider Register
-	-	0x02C	Reserved
POP	W	0x030	NHP Pop Register
MODE	R/W	0x034	NHP Mode Selection Register
-	-	0x038-0xFD4	Reserved
INTCE	W	0xFD8	Interrupt	Clear Enable Register
INTSE	W	0xFDC	Interrupt	Set Enable Register
INTS	R	0xFE0	Interrupt	Status Register
INTE	R	0xFE4	Interrupt	Enable Register



>
> If you don't know what the base address is, well, only NXP and their
> datasheet can help you here.
>
> Cheers!
>
> Pawe?
>
>
>
>



-- 
Jon Smirl
jonsmirl at gmail.com
