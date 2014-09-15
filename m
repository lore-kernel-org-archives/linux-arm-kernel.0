From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Sep 2014 10:30:14 +0100
Subject: [RFC] arm:extend the reserved mrmory for initrd to be page aligned
In-Reply-To: <35FD53F367049845BC99AC72306C23D103D6DB491604@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103D6DB4915FC@CNBJMBX05.corpusers.net>
 <20140915084616.GX12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491604@CNBJMBX05.corpusers.net>
Message-ID: <20140915093014.GZ12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 05:07:53PM +0800, Wang, Yalin wrote:
> Hi
> 
> I tested it on my phone,
> >From log:
> <4>[    0.000000] INITRD unalign phys address:0x02000000+0x0022fb0e
> <4>[    0.000000] INITRD aligned phys address:0x02000000+0x00230000
> 
> <4>[    0.579474] free_initrd_mem: free pfn:8192---8752
> 
> The tail address is not aligned for most initrd image,
> This page will not be freed and lost .

Right, so from this I can assume that you only tested it by seeing what
the addresses were, and the values used in free_initrd_mem().

What you haven't tested is whether the initrd actually gets used with
your changes, which is more what I was interested in given what I found
when reading your patch.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
