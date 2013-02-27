From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 27 Feb 2013 10:35:11 -0500 (EST)
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <20130227102053.GA24274@sig21.net>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com> <20130227073646.GA22333@Corona>
 <20130227095139.GX17833@n2100.arm.linux.org.uk>
 <20130227102053.GA24274@sig21.net>
Message-ID: <alpine.LFD.2.03.1302271027251.1254@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Feb 2013, Johannes Stezenbach wrote:

> On Wed, Feb 27, 2013 at 09:51:39AM +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 27, 2013 at 04:36:47PM +0900, Kyungsik Lee wrote:
> > > Compiler: Linaro ARM gcc 4.6.2
> > > 2. ARMv7, 1.7GHz based board
> > >    Kernel: linux 3.7
> > >    Uncompressed Kernel Size: 14MB
> > >          Compressed Size  Decompression Speed
> > >     LZO  6.0MB            34.1MB/s            Old
> > >          ----------------------------------------
> > >          6.0MB            34.7MB/s            New
> > >          6.0MB            52.2MB/s(UA)
> > >     =============================================
> > >     LZ4  6.5MB            86.7MB/s
> > > UA: Unaligned memory Access support
> > 
> > That is pretty conclusive - it shows an 8% increase in image size vs a
> > 66% increase in decompression speed.  It will take a _lot_ to offset
> > that increase in decompression speed.
> > 
> > So, what I think is that yes, we should accept LZ4 and drop LZO from
> > the kernel - the "fast but may not be small" compression title has
> > clearly been taken by LZ4.
> 
> I think LZO may be used by squashfs, jffs2 and btrfs, thus you
> cannot drop it without breaking on disk storage formats.

It is not about dropping LZO from the kernel entirely.  It's about 
removing support for compressing zImage using LZO (and some others).  
There is no compatibility issue as zImage embeds its own decompression 
code.


Nicolas
