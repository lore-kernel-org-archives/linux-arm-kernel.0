From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 12 Feb 2018 18:45:27 +0000
Subject: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
In-Reply-To: <275feee3-7140-498b-714f-4c88a302d3f6@embeddedor.com>
References: <20180207160002.GA9292@embeddedgus>
 <CAKv+Gu9hmxLSS0ekr8av-ADt3OQjBV=Bt-hRq_-SzWaGODs4SQ@mail.gmail.com>
 <275feee3-7140-498b-714f-4c88a302d3f6@embeddedor.com>
Message-ID: <CAKv+Gu9VTkNN-6MCCuQ2jWFyDMeZKNRyPqMpTWB5jvuSw7MWeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2018 at 18:04, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> Hi Ard,
>
> On 02/08/2018 03:54 AM, Ard Biesheuvel wrote:
>>
>> On 7 February 2018 at 16:00, Gustavo A. R. Silva <gustavo@embeddedor.com>
>> wrote:
>>>
>>> Add suffix ULL to constant 9 in order to give the compiler complete
>>> information about the proper arithmetic to use. Notice that this
>>> constant is used in a context that expects an expression of type
>>> unsigned long long (64 bits, unsigned).
>>>
>>> The expression tfr->len * 9 * 1000000 is currently being evaluated
>>> using 32-bit arithmetic.
>>>
>>> Addresses-Coverity-ID: 1339619
>>
>>
>> What does this number mean? If it is an index into some internal
>> database, please remove it.
>>
>
> This is a unique Coverity identifier. We want to keep information like
> public Bugzilla IDs and tools like Coverity on the commit message.
>

Who is 'we' in this case? And how is this id to any benefit of other
people that have been excluded from 'we'?

If you add identifiers like this, make sure that they don't only make
sense to the in-crowd. For instance, you could replace this with a
http link to the database entry if you really must.
