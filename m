From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Wed, 13 Feb 2013 13:28:41 +0100
Subject: [i2c-mxs] Broken DMA operations from within a module
In-Reply-To: <20130213121450.GA17833@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 13 Feb 2013 12:14:50 +0000")
References: <lyehgkift9.fsf@ensc-virt.intern.sigma-chemnitz.de>
 <20130213121450.GA17833@n2100.arm.linux.org.uk>
Message-ID: <ly8v6sieiu.fsf@ensc-virt.intern.sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>>                .buf = "something",
>> ...
>> random data will be sent because buf is not DMA mapable ("something" is
>> located in the .strtab section within module memory). MXS has a memory
>> layout like
>
> DMA buffers must be located in lowmem *always*.  This means placing them
> in the .data segment does not work.  USB has been through this already
> and it's well known there...

Yes; I know about USB and this requirement is explicitly mentioned in
the 'struct urb' documentation.  But I can not find something similar
for i2c_msg and lot of i2c drivers are working with non DMA mapable
buffers.


Enrico
