From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 13 Nov 2009 23:14:44 +0000
Subject: ARM: big performance waste in memcpy_{from,to}io
In-Reply-To: <200911121749.49676.h.feurstein@gmail.com>
References: <200911121749.49676.h.feurstein@gmail.com>
Message-ID: <20091113231444.GN4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 05:49:49PM +0100, Hubert Feurstein wrote:
> Hi Russel,
> 
> I'm working with an Contec Micro9 board (ep93xx-based with two Spansion-NOR-
> Flash chips in parallel => 32bit memory-buswidth) and was wondering why the
> read-performance of the flash (through /dev/mtd*) is so quite poor. So I 
> connected a logic analyser to the data- and address-bus and recognized that 
> the accesses to the same flash-word-address happens four times. This means 
> that the flash is read byte-by-byte, which is IMO a big waste of performance 
> since it would be possible to read the full word (four bytes) at once. So I 
> digged around in the mtd-driver and found the function "memcpy_fromio" which 
> is called to read the flash data. I was really surprised when looked to the 
> implementation, which is:

Why use this, there's better {read,write}{b,w,l}s calls available which
do the job in lovely optimised assembler.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
