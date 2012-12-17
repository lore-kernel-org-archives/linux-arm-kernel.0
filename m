From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 17 Dec 2012 15:19:51 -0500 (EST)
Subject: [PATCH] ARM: cache: flush to LoUU instead of LoUIS on uniprocessor
 CPUs
In-Reply-To: <1355760642-28559-1-git-send-email-will.deacon@arm.com>
References: <1355760642-28559-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1212171517320.1263@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Dec 2012, Will Deacon wrote:

> flush_cache_louis flushes the D-side caches to the point of unification
> inner-shareable. On uniprocessor CPUs, this is defined as zero and
> therefore no flushing will take place. Rather than invent a new interface
> for UP systems, instead use our SMP_ON_UP patching code to read the
> LoUU from the CLIDR instead.
> 
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

This should be a candidate for the stable tree.


Nicolas
