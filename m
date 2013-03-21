From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 21 Mar 2013 21:22:36 +0100
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130321201533.GN21478@lunn.ch>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <20130321201533.GN21478@lunn.ch>
Message-ID: <20130321212236.1015295d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 21 Mar 2013 21:15:33 +0100, Andrew Lunn wrote:

> Could you recommend a document which introduces LPAE.
> 
> Only being able to address 7GB seems a bit odd to me. I kind of
> expected you set up the translation tables to map a page in the 32 bit
> address range to any arbitrary page in the 40 bit address range. So
> leaving 0xC0000000 to 0xffffffff in the 32bit address range clear is
> easy. But why do you loose space in the 40bit address range?

translation tables convert virtual addresses to physical addresses.
Here, we are only talking about physical addresses. There is an overlap
between the physical addresses used by the RAM, and the physical
addresses at which I/O devices are visible.

And I'm not sure the SDRAM address decoding windows allows to split the
first 4 GB of RAM into two areas, one that would be mapped starting at
physical address 0x0, and another area that would be mapped at a
different address (above 4 GB).

However, I'm unsure why 0xC0000000 was chosen. Why not 0xD0000000,
where the internal registers currently start?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
