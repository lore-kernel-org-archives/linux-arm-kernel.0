From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 23 Sep 2011 15:22:34 +0100
Subject: Identifying Primecells
In-Reply-To: <CAKON4OxHwjrw-dhH2qvXopqUqmKSx2TCPgW4eVHF9dmQO4=Cvw@mail.gmail.com>
References: <CAKON4OxqqBh4xFLwiMZzsGrnoG8erQ0hMFX-_VA-EDMvdNkvQQ@mail.gmail.com>
	<4E7C7FA2.30404@gmail.com>
	<CAKON4OzGEo+XvcNg=mzp3jhq3d3m7Z9bvZTSVCNLNjZ=KYbNBQ@mail.gmail.com>
	<4E7C89FC.4090209@gmail.com>
	<CAKON4OxZPFFL5NAgxLPRw2xxnS=v7iVWtQSSLcUJWfOYh4yfjA@mail.gmail.com>
	<1316787049.4611.920.camel@hornet.cambridge.arm.com>
	<CAKON4OxHwjrw-dhH2qvXopqUqmKSx2TCPgW4eVHF9dmQO4=Cvw@mail.gmail.com>
Message-ID: <1316787754.4611.925.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> My registers don't seem to match up with the pl011 documentation...
<...>
> INTCE	W	0xFD8	Interrupt	Clear Enable Register
> INTSE	W	0xFDC	Interrupt	Set Enable Register
> INTS	R	0xFE0	Interrupt	Status Register
> INTE	R	0xFE4	Interrupt	Enable Register

... nor any other PrimeCell, actually :-)

"Compliant" PrimeCells must have the PCellID in the last 4 registers:

http://infocenter.arm.com/help/topic/com.arm.doc.ddi0183g/I54776.html

* base + 0xff0 = 0x0d
* base + 0xff4 = 0xf0
* base + 0xff8 = 0x05
* base + 0xffc = 0xb1

Cheers!

Pawe?
