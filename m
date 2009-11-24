From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2009 17:03:21 +0000
Subject: [PATCH] Flush the D-cache during copy_user_highpage()
In-Reply-To: <20091124170039.17891.52999.stgit@pc1117.cambridge.arm.com>
References: <20091124170039.17891.52999.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091124170321.GD17481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 05:00:39PM +0000, Catalin Marinas wrote:
> The I and D caches for copy-on-write pages on processors with
> write-allocate caches become incoherent causing problems on application
> relying on CoW for text pages (dynamic linker relocating symbols in a
> text page). This patch flushes the D-cache for such pages.

Don't we need to do this on ARMv7 as well?
