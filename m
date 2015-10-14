From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Oct 2015 16:14:52 +0100
Subject: [PATCHv3 02/11] arm64: Handle section maps for swapper/idmap
In-Reply-To: <561E6FFB.3020005@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-3-git-send-email-suzuki.poulose@arm.com>
 <20151014120618.GB2150@leverpostej> <561E56D4.40506@arm.com>
 <20151014145158.GA4422@leverpostej> <561E6FFB.3020005@arm.com>
Message-ID: <20151014151425.GA5041@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 04:08:43PM +0100, Suzuki K. Poulose wrote:
> On 14/10/15 15:51, Mark Rutland wrote:
> >>>>+/* With 4K pages, we use section maps. */
> 
> >>/*
> >>  * ARM64 kernel is guaranteed to be loaded at 2M aligned
> >>  * address (as per booting requirements). Hence we can use
> >>  * section mapping with 4K (section size = 2M) and not with
> >>  * 16K(section size = 32M) or 64K (section size = 512M).
> >>  */
> >
> >That sounds much better. I hadn't figured out why myself, so thanks for
> >the explanation :)
> >
> >However, there's one minor nit: the start of memory below the kernel is
> >2M aligned, but the offset means that the kernel itself is not loaded at
> >a 2M aligned address.
> 
> Oh yes
> 
> >
> >So how about:
> >
> >/*
> >  * The linear mapping and the start of memory are both 2M aligned (per
> >  * the arm64 booting.txt requirements). Hence we can use section mapping
> >  * with 4K (section size = 2M) but not with 16K (section size = 32M) or
> >  * 64K (section size = 512M).
> >  */
> 
> Will add this

Great.

FWIW, with the changes from this thread applied:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
