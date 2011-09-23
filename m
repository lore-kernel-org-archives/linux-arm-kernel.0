From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 23 Sep 2011 15:10:49 +0100
Subject: Identifying Primecells
In-Reply-To: <CAKON4OxZPFFL5NAgxLPRw2xxnS=v7iVWtQSSLcUJWfOYh4yfjA@mail.gmail.com>
References: <CAKON4OxqqBh4xFLwiMZzsGrnoG8erQ0hMFX-_VA-EDMvdNkvQQ@mail.gmail.com>
	<4E7C7FA2.30404@gmail.com>
	<CAKON4OzGEo+XvcNg=mzp3jhq3d3m7Z9bvZTSVCNLNjZ=KYbNBQ@mail.gmail.com>
	<4E7C89FC.4090209@gmail.com>
	<CAKON4OxZPFFL5NAgxLPRw2xxnS=v7iVWtQSSLcUJWfOYh4yfjA@mail.gmail.com>
Message-ID: <1316787049.4611.920.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Is peripheral use documented at ARM for the lpc3130? What I don't know
> is if the peripherals have been modified or replaced with an
> alternative implementation.
> 
> So I guess I need to figure out how to read the ID register.

I'm not sure what your problem exactly is, but if you want to know what
PeriphID for PL011 is, have a look here:

http://infocenter.arm.com/help/topic/com.arm.doc.ddi0183g/I18381.html

So if your UART is PL011, reading four 8-bit wide registers at
* base + 0xfe0
* base + 0xfe4
* base + 0xfe8
* base + 0xfec
should give you (respectively):
* 0x11
* 0x10
* 0x_4 (_ depends on the cell revision)
* 0x00

Of course AMBA bus match_id will do this for you so, as I said, I'm not
sure what the problem is...

If you don't know what the base address is, well, only NXP and their
datasheet can help you here.

Cheers!

Pawe?
