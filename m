From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 8 Mar 2017 14:38:00 +0000
Subject: Neophyte questions about PCIe
In-Reply-To: <b735b894-4c6c-5eb0-524e-dccee648d0f8@free.fr>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7A70A@AcuExch.aculab.com>
 <b735b894-4c6c-5eb0-524e-dccee648d0f8@free.fr>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFE7A879@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mason
> Sent: 08 March 2017 14:18
...
> > Don't think config space fits.
> > With the 'obvious' mapping the 'bus number' is in the top
> > 8 bits of the address.
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> 
> 	cfg_offset(bus, device, function, register) =
> 		bus << 20 | device << 15 | function << 12 | register
> 
> 8 bits for bus, 5 bits for device, 3 bits for function, 12 bits for reg offset
> 1 MB per bus, 256 buses max => 256 MB max
> 
> Supporting "only" 64 buses is good enough, I believe.

I was comparing the PCIe TLP layout for config cycles and normal read/write.
There bus/dev/fun are in the top 16 bits with 4 reserved bits above the
register address (effectively allowing 64k of config space per function).

Possibly some logic shifting the address across for config cycles.

The TLP type also has a bit for type-0 v type-1 config cycles.
I can't quite remember the difference.

	David
