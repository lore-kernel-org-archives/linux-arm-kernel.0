From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 3 Nov 2017 14:58:32 -0700
Subject: [PATCH 12/12] hwrng: bcm63xx-rng: Remove since bcm2835-rng takes
 over
In-Reply-To: <877ev7ru97.fsf@anholt.net>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
 <20171102010408.27736-13-f.fainelli@gmail.com> <877ev7ru97.fsf@anholt.net>
Message-ID: <cd6ab76c-1e33-6a3b-efce-e661c647c4db@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2017 01:18 PM, Eric Anholt wrote:
> Florian Fainelli <f.fainelli@gmail.com> writes:
> 
>> bcm2835-rng is now capable of supporting the BCM63xx hardware, so remove
>> the driver which duplicates the same functionality.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/char/hw_random/Kconfig       |  13 ---
>>  drivers/char/hw_random/Makefile      |   1 -
>>  drivers/char/hw_random/bcm63xx-rng.c | 154 -----------------------------------
>>  3 files changed, 168 deletions(-)
>>  delete mode 100644 drivers/char/hw_random/bcm63xx-rng.c
>>
> 
>> diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
>> deleted file mode 100644
>> index 5132c9cde50d..000000000000
>> --- a/drivers/char/hw_random/bcm63xx-rng.c
>> +++ /dev/null
> 
>> -static int bcm63xx_rng_data_present(struct hwrng *rng, int wait)
>> -{
>> -	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
>> -
>> -	return __raw_readl(priv->regs + RNG_STAT) & RNG_AVAIL_MASK;
>> -}
> 
> It looks like this method isn't in the 2835 implementation.  Should it
> get ported over?

The read method already has something similar in that it busy loops
until it gets some random words available, which is why I did not port
it over.
-- 
Florian
