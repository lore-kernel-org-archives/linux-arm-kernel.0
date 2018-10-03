From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Wed, 3 Oct 2018 17:27:52 +0200
Subject: [PATCH] spi: pxa2xx: Mark expected switch fall-through
In-Reply-To: <20181003152255.GE7132@sirena.org.uk>
References: <20181003121211.GA28108@embeddedor.com>
 <20181003152255.GE7132@sirena.org.uk>
Message-ID: <22e7d33d-db33-d2e4-30b1-fa87176e4277@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/3/18 5:22 PM, Mark Brown wrote:
> On Wed, Oct 03, 2018 at 02:12:11PM +0200, Gustavo A. R. Silva wrote:
> 
>>  			switch (drv_data->n_bytes) {
>>  			case 4:
>>  				bytes_left >>= 1;
>> +				/* Fall through */
>>  			case 2:
>>  				bytes_left >>= 1;
>>  			}
> 
> I think this code is just being too cute and it'd be better to just
> rewrite it to directly do the expected number of shifts directly in each
> case and have break statements; your fix is good but still not ideal for
> readability I think.
> 

Okay. I agree. I'll rewrite and send v2.

Thanks
--
Gustavo
