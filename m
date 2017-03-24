From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 24 Mar 2017 22:13:30 +0800
Subject: [PATCH 0/7] crypto: caam - add Queue Interface (QI) support
In-Reply-To: <20170317100602.2837-1-horia.geanta@nxp.com>
References: <20170317100602.2837-1-horia.geanta@nxp.com>
Message-ID: <20170324141330.GD14780@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 12:05:55PM +0200, Horia Geant? wrote:
> RFC -> v1:
> -rebased on latest cryptodev-2.6 tree
> open-code tsk_cpus_allowed() - sync with commit
> 0c98d344fe5c "sched/core: Remove the tsk_cpus_allowed() wrapper"
> -addressed Scott's feedback - removed most of the accessors
> added in soc/qman (patch 4) and instead open-coded them in caam/qi
> 
> 
> The patchset adds support for CAAM Queue Interface (QI), the additional
> interface (besides job ring) available for submitting jobs to the engine
> on platforms having DPAA (Datapath Acceleration Architecture).
> 
> Patches 1-4 are QMan dependencies.
> During RFC stage, we agreed to go with them through the crypto tree:
> https://www.mail-archive.com/linux-crypto at vger.kernel.org/msg24105.html
> 
> Patch 5 adds a missing double inclusion guard in desc_constr.h.
> 
> Patch 6 adds the caam/qi job submission backend.
> 
> Patch 7 adds algorithms (ablkcipher and authenc) that run on top
> of caam/qi. For now, their priority is set lower than caam/jr.

All patches applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
