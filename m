From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 12 Jul 2012 14:16:01 -0400 (EDT)
Subject: Where to put a large bootloader-supplied device tree on ARM ?
In-Reply-To: <4FFE743B.6080504@firmworks.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <201207051454.24475.arnd@arndb.de> <20120705161600.GA28860@lunn.ch>
 <201207062008.23952.arnd@arndb.de> <20120706210009.GC11470@lunn.ch>
 <4FF781D8.3040206@firmworks.com>
 <2966DB01BC317A4DA23684BA0F653415013701@xmb-aln-x08.cisco.com>
 <4FF7980E.7050705@firmworks.com>
 <alpine.LFD.2.02.1207090015270.31100@xanadu.home>
 <4FFE743B.6080504@firmworks.com>
Message-ID: <alpine.LFD.2.02.1207121411180.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jul 2012, Mitch Bradley wrote:
> On 7/8/2012 6:30 PM, Nicolas Pitre wrote:
> > On Fri, 6 Jul 2012, Mitch Bradley wrote:
> > 
> >> For now, I'm putting the initrd at the end of memory and the dtb
> >> below that.  That seems to work, but I'm unsure whether or not
> >> I'm just "getting lucky".
> > 
> > That's also perfectly fine.
> 
> Alas, that worked for machines with 512 MiB of main memory, but failed
> on 1 GiB machines.  My guess is that, when the initrd and dtb are near
> the top of a 1 GiB memory, the virtual address gets too near the top of
> the kernel's 1 GiB of virtual space (which starts at 0xc0000000),
> perhaps colliding with the VMALLOC space.

Indeed, that won't work in that case.

> Putting them just below the 128 MiB boundary seems to work.

Or at the 128MB mark, or any location between 64MB and 512MB should be 
fine in practice.


Nicolas
