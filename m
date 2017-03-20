From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 20 Mar 2017 20:24:01 +0200
Subject: Question - seeding the hw pseudo random number generator
In-Reply-To: <20170320132858.GA27044@gondor.apana.org.au>
References: <20170318092554.lggkhfg5eko23o3k@kozik-lap>
 <CANc+2y5gv2ygSM4HF69XCW7Bb8UUHN+qJKq0os-mOvYknH+SeQ@mail.gmail.com>
 <20170320132858.GA27044@gondor.apana.org.au>
Message-ID: <20170320182401.x2yhl5pcpqihcvj3@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 09:28:58PM +0800, Herbert Xu wrote:
> On Mon, Mar 20, 2017 at 12:19:32PM +0530, PrasannaKumar Muralidharan wrote:
> >
> > AF_ALG interface for rng does have seeding support. I think hw_random
> > does not provide seeding support intentionally as I understand that
> > True RNG need not require seeding (please correct me if I am wrong).
> 
> Yes.  We should be converting PRNGs in hwrng over to algif_rng.

The actual hardware block can be seeded from true RNG (taking data
from thermal noise) so the solutions (if I understand correctly) for
exynos-rng might be:
1. Seed from internal TRNG making it a proper hwrandom device,
2. Convert to AF_ALG and seed with data from user-space through that
   interface.

Thanks for explanation, I'll queue it to my tasks list.

Best regards,
Krzysztof
