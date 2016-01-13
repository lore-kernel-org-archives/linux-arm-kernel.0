From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 22:46:30 +0100
Subject: [PATCH] null_blk: use sector_div instead of do_div
In-Reply-To: <5665391.6n2Zq774pT@wuerfel>
References: <3768541.ja0r6f0Odi@wuerfel> <56596064.2070306@bjorling.me>
 <5665391.6n2Zq774pT@wuerfel>
Message-ID: <4333086.QZV0XpURJu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 December 2015 17:13:40 Arnd Bergmann wrote:
> On Saturday 28 November 2015 09:05:56 Matias Bj?rling wrote:
> > 
> > I had my head around the original code and kept references to the device 
> > layout I had in mind. 256 being number of pages in a block, and the 2^16 
> > being number of blocks in a lun and wanted to communicate that part.. 
> > which led to producing silly code in the mean time.
> > 
> > Similarly, the bs is always fixed to 4k for lightnvm, until other bs 
> > sizes are supported. We could optimize it out, I left it in for the same 
> > reasons.
> 
> I still see the build warning in linux-next, can you merge your patch?

The merge window is open now, the bug persists in linux-next. I'm
submitting Matias version now.

	Arnd
