From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 2 Dec 2011 09:41:12 -0800
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174FDB01C6@HQMAIL01.nvidia.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
 <20111130153749.GE2045@localhost.localdomain>
 <1322673302.3180.25.camel@hornet.cambridge.arm.com>
 <20111130175410.GJ2045@localhost.localdomain>
 <alpine.LFD.2.02.1111301522340.2357@xanadu.home>
 <20111130204805.GA5698@sirena.org.uk>
 <alpine.LFD.2.02.1111301604230.2357@xanadu.home>
 <20111201111049.GB2915@opensource.wolfsonmicro.com>
 <20111201121403.GC2026@localhost.localdomain>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDB01C6@HQMAIL01.nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174FDB0539@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Thursday, December 01, 2011 9:20 AM:
> Dave Martin wrote at Thursday, December 01, 2011 5:14 AM:
> > On Thu, Dec 01, 2011 at 11:10:50AM +0000, Mark Brown wrote:
> > > On Wed, Nov 30, 2011 at 04:38:26PM -0500, Nicolas Pitre wrote:
> > > > On Wed, 30 Nov 2011, Mark Brown wrote:
> > >
> > > > > Oh, dear.  Any pointers to the discussions on the u-boot side?
> > >
> > > > Certainly.  Many different threads actually.  Here's a few:
> > >
> > > OK, thanks - I see Stephen just followed up and Wolfgang seems
> > > moderately happy so hopefully there will be some progress.  It also
> > > occurs to me that there's at least Qi also using uImages, hopefully
> > > other bootloaders are going to be easier to deal with (or already cope).
> >
> > If Stephen's patches are heading for merge, that's great.
> >
> > If this feature remains blocked though, could we support Wolfgang's
> > preference for start-of-RAM-relative load and entry address?
> 
> It looks like my change is progressing to being checked in:
> 
> http://lists.denx.de/pipermail/u-boot/2011-December/111865.html

For the record, the changes are now in U-Boot master:

d510859 image: Don't detect XIP images as overlapping.
b9b50e8 image: Implement IH_TYPE_KERNEL_NOLOAD

I should also note that Marek Vasut posted some patches to implement a
bootz command in U-Boot. This turned out to be much less invasive than
I originally thought, so once those patches are finalized, uImage might
be irrelevant except for initrds (U-Boot already accepts a raw FDT
without uImage wrapping for bootm and hence bootz).

http://www.mail-archive.com/u-boot at lists.denx.de/msg69287.html

-- 
nvpublic
