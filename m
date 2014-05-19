From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 19 May 2014 18:15:11 +0100
Subject: [PATCH 4/6] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140519161217.GX12304@sirena.org.uk>
References: <1399063112-16917-1-git-send-email-broonie@kernel.org>
 <1399063112-16917-5-git-send-email-broonie@kernel.org>
 <53763DFC.8070309@arm.com> <20140516183915.GP22111@sirena.org.uk>
 <5379D594.2000200@arm.com>
 <20140519105405.GC5935@e102568-lin.cambridge.arm.com>
 <20140519123314.GU12304@sirena.org.uk>
 <20140519141323.GA2917@e102568-lin.cambridge.arm.com>
 <20140519161217.GX12304@sirena.org.uk>
Message-ID: <20140519171511.GA5240@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 05:12:17PM +0100, Mark Brown wrote:

[...]

> > Do not bother, use three affinity levels and be done with that, we will
> > deal with aff3 (and aff2) when time comes.
> 
> This would leave the MPIDR support worse than DT which seems retrograde
> especially given that it's so simple to differentiate the clusters.  The
> only issue with that appears to be about precisely how to make up the
> cluster numbers which is a cosmetic one.

That's the reason why I said you should not bother. If you want to use
4 affinity levels, I do not see the point in using the hash for that though,
since all we need is a unique id which can be easily created without
resorting to hashing.

Hashing compresses the cluster index, but that index is not representative
of HW anyway. If you go for simple shifting we might end up with huge cluster
ids, which is fine but a bit weird.

So either (1) you use three affinity levels or (2) the simplest way to combine
the affinity levels.

I personally do not like squashing affinity levels, but I can live with
that as long as we are done with this, functionality is ready and it is
time we get that in.

Thanks,
Lorenzo
