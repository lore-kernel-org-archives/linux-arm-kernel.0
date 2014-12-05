From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Dec 2014 12:31:17 +0000
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <2131163.V0fUaF9isN@wuerfel>
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
 <3551792.oHatG1W6W1@wuerfel>
 <20141205110507.GB28339@e104818-lin.cambridge.arm.com>
 <2131163.V0fUaF9isN@wuerfel>
Message-ID: <20141205123116.GD28339@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 12:24:49PM +0000, Arnd Bergmann wrote:
> On Friday 05 December 2014 11:05:07 Catalin Marinas wrote:
> > 
> > > Should we add support for 64k-pages in the arm32 kernel as well now?
> > 
> > 32-bit LPAE doesn't support 64K pages but IIRC the classic MMU does
> > (though I have to check whether it was optional). But it's not feasible
> > to enable this in a 32-bit environment because of the memory wasted with
> > large pages (on average 32KB per mapped file, possibly even more if you
> > have lots of small files).
> 
> That sounds like a tradeoff that some users might be willing to make.
> 
> I remember that with ps3-linux, a lot of people wanted to enable 64k-pages
> because the Cell processor has such a small number of TLB entries (256 or
> 1024), but Linux only has around 200MB of memory available. I believe
> there are arm32 machines with more RAM and fewer TLBs.

I've heard that the WD MyCloud NAS (Cortex-A9 based) moved to 64K pages
and they rebuilt the filesystem (which annoyed some people that were
previously installing Debian packages directly, they now need
recompilation).

-- 
Catalin
