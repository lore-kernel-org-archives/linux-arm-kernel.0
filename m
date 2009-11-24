From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Nov 2009 17:06:15 +0000
Subject: [PATCH] Flush the D-cache during copy_user_highpage()
In-Reply-To: <20091124170321.GD17481@n2100.arm.linux.org.uk>
References: <20091124170321.GD17481@n2100.arm.linux.org.uk>
Message-ID: <1259082375.16239.37.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-11-24 at 17:03 +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 24, 2009 at 05:00:39PM +0000, Catalin Marinas wrote:
> > The I and D caches for copy-on-write pages on processors with
> > write-allocate caches become incoherent causing problems on application
> > relying on CoW for text pages (dynamic linker relocating symbols in a
> > text page). This patch flushes the D-cache for such pages.
> 
> Don't we need to do this on ARMv7 as well?

Do you mean an improvement to the patch description?

-- 
Catalin
