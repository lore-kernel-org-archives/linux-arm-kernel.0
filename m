From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 Jan 2013 10:49:01 +0800
Subject: [PATCH 2/2] ARM: use DEBUG_LL infrastructural for multiplatform
 uncompress debug
In-Reply-To: <201301171625.42456.arnd@arndb.de>
References: <1358436119-30808-1-git-send-email-shawn.guo@linaro.org>
 <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
 <201301171625.42456.arnd@arndb.de>
Message-ID: <20130118024858.GA31381@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 04:25:42PM +0000, Arnd Bergmann wrote:
> On Thursday 17 January 2013, Shawn Guo wrote:
> > However, there is a problem with above approach.  DEBUG_LL routines
> > will check MMU enable bit to decide whether physical or virtual address
> > should be used to access debug port.  In case virtual address needs
> > to be used, the address returned by addruart will not work for
> > decompressor who uses a different mapping from what kernel uses.
> > Fortunately, decompressor uses a flat mapping (same physical and virtual
> > addresses).  So we can easily work it around by asking platform addruart
> > return physical address as virtual address when it runs in decompressor.
> > The macro UNCOMPRESS_DEBUG is defined for this use.
> 
> Can't you just create a new copy of kernel/debug.S in boot/compressed/
> that provides only a putc() function and uses the physical address
> unconditionally?
> 
Why did I not think of this?  The approach is obviously simpler.
Please check the updated version I just sent out.  Thanks.

Shawn
