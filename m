From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 24 May 2013 23:53:19 -0400 (EDT)
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130523104303.GC16722@arm.com>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <20130523104303.GC16722@arm.com>
Message-ID: <alpine.LFD.2.03.1305242350220.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 May 2013, Catalin Marinas wrote:

> An issue is that for kunmap_atomic() && VIVT we flush the same page
> twice. I don't think we should remove the cache flushing in
> __kunmap_atomic() for VIVT since not all kunmap_atomic() calls require
> flush_kernel_dcache_page() (unless we just assume that highmem && vivt
> don't work together).

VIVT and highmem do work together.  Highmem for ARM was in fact 
developed on such a platform.


Nicolas
