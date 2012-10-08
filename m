From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Oct 2012 18:43:40 +0100
Subject: [PATCH V2 1/2] ARM: remove unnecessary flush of anon pages in
 flush_dcache_page()
In-Reply-To: <20121008173827.GB11786@schnuecks.de>
References: <1349609352-6408-1-git-send-email-gmbnomis@gmail.com>
 <1349609352-6408-2-git-send-email-gmbnomis@gmail.com>
 <20121008113606.GB31458@arm.com>
 <20121008173827.GB11786@schnuecks.de>
Message-ID: <20121008174340.GA3204@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 06:38:27PM +0100, Simon Baatz wrote:
> Hi Catalin,
> 
> On Mon, Oct 08, 2012 at 12:36:07PM +0100, Catalin Marinas wrote:
> > On Sun, Oct 07, 2012 at 12:29:11PM +0100, Simon Baatz wrote:
> > > On non-aliasing VIPT D-caches, there is no need to flush the kernel
> > > mapping of anon pages in flush_dcache_page() directly.  If the page is
> > > mapped as executable later, the necessary D/I-cache flush will be done
> > > in __sync_icache_dcache().
> > > 
> > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> 
> Thanks for the ack! However, while this improvement is nice to have,
> I care more about fixing that nasty data corruption on VIVT/VIPT
> aliasing caches with the second patch.  In case you cannot offer a
> Acked-by or Reviewed-by for the patch for technical reasons, could
> you please explain your reservations against the fix?

I was busy with other things today and didn't have time to get back to
this thread. I'll post a question though.

-- 
Catalin
