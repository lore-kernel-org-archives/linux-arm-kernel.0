From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 7 Jan 2014 18:05:45 +0000
Subject: [PATCH 0/4] arm64 topology support
In-Reply-To: <1387483575-11430-1-git-send-email-broonie@kernel.org>
References: <1387483575-11430-1-git-send-email-broonie@kernel.org>
Message-ID: <20140107180545.GB14603@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 08:06:11PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Another spin of the arm64 topology work - this should incorporate most
> of the feedback from Lorenzo, there's a few things that were still under
> discussion the main ones being:
> 
>  - Should we have a smp_store_cpu_info(); like I say I like the errors
>    it generates for omitted cores and the reuse of the SMP enumeration
>    code (and cross-check with that I guess - make sure we don't get
>    confused about which CPUs are getting enabled).

I agree, we should keep it, it makes sense.

>  - Should we update the binding to allow cores in the root cpu_map node
>    (since it's less effort in code and not a meaningful difference
>    semantically), warn if we find cores in the cpu_map node or actively
>    reject such DTs?

I think cpu-map must only contain cluster nodes as descendant children. This
to prevent creative DTs with cluster and core nodes at top topology level.
Overall it makes sense, cores can only exist in a cluster container, might
seem churn but at least that's strict.

> In both cases I don't much mind but I think what's there is reasonable
> so I've left the code as-is pending further feedback.  I also didn't
> update the code to get more reuse of the iteration code, like I said I
> did look at that when writing the code but couldn't find anything that
> actually made things more pleasant but if someone has some ideas...

I still think that most of the DT parsing code can and should be reused
also for other purposes (eg IRQ affinity). Comments on the patches
concerned.

Lorenzo
