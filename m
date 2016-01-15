From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Jan 2016 18:01:07 +0000
Subject: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
In-Reply-To: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
Message-ID: <20160115180107.GC6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 02:09:28PM +0000, Juri Lelli wrote:

> Second version of this RFC proposes an alternative solution (w.r.t. v1) to the
> problem of how do we init CPUs original capacity: we run a bogus benchmark (for
> this RFC I simple stole int_sqrt from lib/ and I run that in a loop to perform
> some integer computation, I'm sure there are better benchmarks around) on the
> first cpu of each frequency domain (assuming no u-arch differences inside
> domains), measure time to complete a fixed number of iterations and then
> normalize results to SCHED_CAPACITY_SCALE (1024). I didn't spend much time in
> polishing this up or thinking about a better benchmark, as this is an RFC and
> I'd like discussion happening before we make this solution better
> working/looking. However, surprisingly, results are not that bad already:

This approach looks good to me - certainly vastly preferable to putting
the numbers into DT.

>  2. Dynamic profiling at boot (v2)
> 
>     pros: - does not require a standardized definition of capacity
>           - cannot be incorrectly tuned (once benchmark is fixed)
>           - does not require user/integrator work

>     cons: - not easy to come up with a clean solution, as it seems interaction
>             with several subsystems (e.g., cpufreq) is required

This actually seems to be pretty clean.

>           - not easy to agree upon a single benchmark (that has to be both
>             representative and simple enough to run at boot)
>           - numbers might (and do) vary from boot to boot

This does come back to the question of how accurate the numbers need to
be - is "good enough" fine?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160115/c5e77b24/attachment.sig>
