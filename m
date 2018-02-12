From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 12 Feb 2018 11:57:20 -0600
Subject: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
In-Reply-To: <87inb7c2ld.fsf@anholt.net>
References: <20180207160002.GA9292@embeddedgus> <87inb7c2ld.fsf@anholt.net>
Message-ID: <c3e615e4-5c2d-4c3c-0417-5c04230bd5e5@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 02/08/2018 02:22 AM, Eric Anholt wrote:
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
> 
>> Add suffix ULL to constant 9 in order to give the compiler complete
>> information about the proper arithmetic to use. Notice that this
>> constant is used in a context that expects an expression of type
>> unsigned long long (64 bits, unsigned).
>>
>> The expression tfr->len * 9 * 1000000 is currently being evaluated
>> using 32-bit arithmetic.
>>
>> Addresses-Coverity-ID: 1339619
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> The effect looks like it would be that we would have chosen polling mode
> instead of waiting for interrupts for some transfers >477 seconds.
> Seems like a good fix for an unlikely bug.
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>
> 

Thank you for your review.

--
Gustavo
