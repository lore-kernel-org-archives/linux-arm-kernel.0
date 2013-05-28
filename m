From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 May 2013 10:55:28 +0100
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <alpine.LFD.2.03.1305242350220.1918@syhkavp.arg>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <20130523104303.GC16722@arm.com>
 <alpine.LFD.2.03.1305242350220.1918@syhkavp.arg>
Message-ID: <20130528095528.GA14329@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 25, 2013 at 04:53:19AM +0100, Nicolas Pitre wrote:
> On Thu, 23 May 2013, Catalin Marinas wrote:
> 
> > An issue is that for kunmap_atomic() && VIVT we flush the same page
> > twice. I don't think we should remove the cache flushing in
> > __kunmap_atomic() for VIVT since not all kunmap_atomic() calls require
> > flush_kernel_dcache_page() (unless we just assume that highmem && vivt
> > don't work together).
> 
> VIVT and highmem do work together.  Highmem for ARM was in fact 
> developed on such a platform.

Thanks for confirming. Do you remember why kunmap() doesn't (need to)
flush the cache alias (for VIVT)? Or if it does, where?

-- 
Catalin
