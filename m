From: freude@linux.vnet.ibm.com (Harald Freudenberger)
Date: Thu, 23 Mar 2017 09:03:23 +0100
Subject: Question - seeding the hw pseudo random number generator
In-Reply-To: <1509135.hmo2UhaKWe@tauon.atsec.com>
References: <20170318092554.lggkhfg5eko23o3k@kozik-lap>
 <CANc+2y5gv2ygSM4HF69XCW7Bb8UUHN+qJKq0os-mOvYknH+SeQ@mail.gmail.com>
 <20170320132858.GA27044@gondor.apana.org.au>
 <1509135.hmo2UhaKWe@tauon.atsec.com>
Message-ID: <602a68ef-c57a-0092-ebe0-161ec602fad6@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2017 02:39 PM, Stephan M?ller wrote:
> Am Montag, 20. M?rz 2017, 14:28:58 CET schrieb Herbert Xu:
>
> Hi Herbert,
>
>> On Mon, Mar 20, 2017 at 12:19:32PM +0530, PrasannaKumar Muralidharan wrote:
>>> AF_ALG interface for rng does have seeding support. I think hw_random
>>> does not provide seeding support intentionally as I understand that
>>> True RNG need not require seeding (please correct me if I am wrong).
>> Yes.  We should be converting PRNGs in hwrng over to algif_rng.
> IMHO this not only applies to the PRNGs in drivers/crypto (which should simply 
> register with crypto_register_rngs) but also to ~/hacking/sources/linux/arch/
> s390/crypto/prng.c which exports a /dev/prandom file.
>
> For the seeding, it may make sense to follow the example given with crypto/
> drbg.c using the add_random_ready_callback function.
>
> Ciao
> Stephan
>

I'll have a look on it. Currently the s390/crypto/prng seeds itself with
an algorithm based on the jitter of the very fine granular hardware
clock of a s390 machine. There were some thoughts and measurements
by an mathematician which let to this algorithm. However, long-term
the s390 platform will provide some kind of true hardware random number
generator and the idea is to use this for seeding the prng.

regards
Harald Freudenberger
