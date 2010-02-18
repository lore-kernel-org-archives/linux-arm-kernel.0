From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 17 Feb 2010 23:18:26 -0500 (EST)
Subject: race between kmap shootdown and cache maintenance
In-Reply-To: <d6200be21002171800m7f03f94blbb17d68bce4a9302@mail.gmail.com>
References: <A0A1E7539300DF49AA383E614C7827BC048DB1096B@HQMAIL01.nvidia.com>
	<20100207153045.GA30457@n2100.arm.linux.org.uk>
	<A0A1E7539300DF49AA383E614C7827BC048DB10979@HQMAIL01.nvidia.com>
	<alpine.LFD.2.00.1002082229480.1681@xanadu.home>
	<A0A1E7539300DF49AA383E614C7827BC048DB10984@HQMAIL01.nvidia.com>
	<alpine.LFD.2.00.1002082310420.1681@xanadu.home>
	<A0A1E7539300DF49AA383E614C7827BC048DB10A1D@HQMAIL01.nvidia.com>
	<d6200be21002171800m7f03f94blbb17d68bce4a9302@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1002172316240.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Feb 2010, Arve Hj?nnev?g wrote:

> On Fri, Feb 12, 2010 at 5:08 PM, Gary King <GKing@nvidia.com> wrote:
> > I finally got a chance to test this; it looks like this condition may be common: many (all?) of the various page cache-like things seem to just hand pages to flush_dcache_page blindly, and expect flush_dcache_page to determine whether or not maintenance is required.
> >
> > With your patch, I immediately hit the BUG() when the init process is started; the backtrace is attached as unpinned_maint.log.
> 
> I see the same crash on Nexus One with this patch applied to a
> 2.6.33-rc8 kernel.
> 
> If I change the BUG_ON to WARN_ON, the system boot further, but the
> warning triggers the bug.
> 
> If I also apply the fix from this thread the system boots again, and I
> see several calls that do not have the kmap-high pinned.

OK.  After further considerations, I think the original patch is 
legitimate.


Nicolas
