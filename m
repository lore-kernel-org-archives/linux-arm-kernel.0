From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 11 Apr 2017 10:09:50 +0200
Subject: [PATCH v4 2/2] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170410105547.GA8615@gondor.apana.org.au>
References: <20170408133245.30147-1-krzk@kernel.org>
 <20170408133245.30147-3-krzk@kernel.org>
 <20170410105547.GA8615@gondor.apana.org.au>
Message-ID: <CAJKOXPe4gDFWqNwa1WqADTv2Zv_wu3pVpEaefPz5POk8mVeaqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 12:55 PM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> On Sat, Apr 08, 2017 at 03:32:45PM +0200, Krzysztof Kozlowski wrote:
>>
>> +static struct rng_alg exynos_rng_alg = {
>> +     .generate               = exynos_rng_generate,
>> +     .seed                   = exynos_rng_seed,
>> +     .seedsize               = EXYNOS_RNG_SEED_SIZE,
>> +     .base                   = {
>> +             .cra_name               = "exynos_rng",
>
> Please use stdrng.  Or is there a reason why this can't be used
> by the crypto layer itself?

I think there is no reason against, I'll fix it.

Best regards,
Krzysztof
