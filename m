From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Mon, 20 Mar 2017 14:39:47 +0100
Subject: Question - seeding the hw pseudo random number generator
In-Reply-To: <20170320132858.GA27044@gondor.apana.org.au>
References: <20170318092554.lggkhfg5eko23o3k@kozik-lap>
 <CANc+2y5gv2ygSM4HF69XCW7Bb8UUHN+qJKq0os-mOvYknH+SeQ@mail.gmail.com>
 <20170320132858.GA27044@gondor.apana.org.au>
Message-ID: <1509135.hmo2UhaKWe@tauon.atsec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 20. M?rz 2017, 14:28:58 CET schrieb Herbert Xu:

Hi Herbert,

> On Mon, Mar 20, 2017 at 12:19:32PM +0530, PrasannaKumar Muralidharan wrote:
> > AF_ALG interface for rng does have seeding support. I think hw_random
> > does not provide seeding support intentionally as I understand that
> > True RNG need not require seeding (please correct me if I am wrong).
> 
> Yes.  We should be converting PRNGs in hwrng over to algif_rng.

IMHO this not only applies to the PRNGs in drivers/crypto (which should simply 
register with crypto_register_rngs) but also to ~/hacking/sources/linux/arch/
s390/crypto/prng.c which exports a /dev/prandom file.

For the seeding, it may make sense to follow the example given with crypto/
drbg.c using the add_random_ready_callback function.

Ciao
Stephan
