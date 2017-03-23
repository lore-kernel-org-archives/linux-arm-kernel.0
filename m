From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 23 Mar 2017 09:23:07 +0100
Subject: Question - seeding the hw pseudo random number generator
In-Reply-To: <20170320132858.GA27044@gondor.apana.org.au>
References: <20170318092554.lggkhfg5eko23o3k@kozik-lap>
 <CANc+2y5gv2ygSM4HF69XCW7Bb8UUHN+qJKq0os-mOvYknH+SeQ@mail.gmail.com>
 <20170320132858.GA27044@gondor.apana.org.au>
Message-ID: <20170323082307.GB16625@Red>
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
> 

Problem with this conversion, a huge regression for user space.
Using hwrng is simple as cat /dev/hwrng.
Using algif_rng via AF_ALG is ... unusable for the moment.
Perhaps creating an user space tool (prng-tool which provide a cat /dev/hwrng replacement) is mandatory before any convertion.

Regards
