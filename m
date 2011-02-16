From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Feb 2011 12:36:11 +0000
Subject: [PATCH] ARM: errata: pl310 cache sync operation may be faulty
In-Reply-To: <20110216123410.GA6267@bnru02>
References: <1297768683-30273-1-git-send-email-srinidhi.kasagar@stericsson.com>
	<20110215113422.GE4152@n2100.arm.linux.org.uk>
	<20110216060351.GB16604@bnru02>
	<AANLkTi=svL42XJE-61H16B-jgwwu-+pXjS3QcMKNJN6Z@mail.gmail.com>
	<20110216123410.GA6267@bnru02>
Message-ID: <1297859771.28844.33.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-02-16 at 12:34 +0000, Srinidhi KASAGAR wrote:
> From 7a1fa2f8ec106bda4f940f5c9478ec16b2de6846 Mon Sep 17 00:00:00 2001
> From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Date: Mon, 14 Feb 2011 17:07:06 +0530
> Subject: [PATCH] ARM: errata: pl310 cache sync operation may be faulty
> 
> The effect of cache sync operation is to drain the store
> buffer and wait for all internal buffers to be empty. In
> normal conditions, store buffer is able to merge the
> normal memory writes within its 32-byte data buffers.
> Due to this erratum present in r3p0, the effect of cache
> sync operation on the store buffer still remains when
> the operation completes. This means that the store buffer
> is always asked to drain and this prevents it from merging
> any further writes.
> 
> This can severely affect performance on the write traffic
> esp. on Normal memory NC one.
> 
> The proposed workaround is to replace the normal offset of
> cache sync operation(0x730) by another offset targeting an
> unmapped PL310 register 0x740.
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
