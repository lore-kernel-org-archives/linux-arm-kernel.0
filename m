From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Jun 2012 22:17:39 +0100
Subject: [RFC PATCH 1/2] ARM: use generic strnlen_user and
 strncpy_from_user functions
In-Reply-To: <alpine.LFD.2.02.1206112253040.23555@xanadu.home>
References: <1339169935-31775-1-git-send-email-will.deacon@arm.com>
 <1339169935-31775-2-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1206112253040.23555@xanadu.home>
Message-ID: <20120612211738.GB24380@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 03:53:56AM +0100, Nicolas Pitre wrote:
> On Fri, 8 Jun 2012, Will Deacon wrote:
> 
> > This patch implements the word-at-a-time interface for ARM using the
> > same algorithm as x86. Although we have a clz instruction from ARMv5,
> > this only saves us one mov instruction when building with Thumb-2 and
> > makes no difference when targetting ARM, so we use the magic 0x0ff0001
> > constant for all CPUs. For big-endian configurations, we use the
> > implementation from asm-generic.
> > 
> > With this implemented, we can replace our byte-at-a-time strnlen_user
> > and strncpy_from_user functions with the optimised generic versions.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> With the updated patch comment...
> 
> Reviewed-by: Nicolas Pitre <nico@linaro.org>

Thanks Nicolas. I'll post a v2 with the updated change log and your
reviewed-bys. I may also CC lkml in case somebody over there has some
better benchmarks for this stuff.

Cheers,

Will
