From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Jan 2018 11:46:07 +0000
Subject: [PATCH 0/7] arm64: move literal data into .rodata section
In-Reply-To: <20180118114112.GA20091@gondor.apana.org.au>
References: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
 <20180118114112.GA20091@gondor.apana.org.au>
Message-ID: <CAKv+Gu_oh7q81mr=XPW+HM9zewETtbL=mnN0mkr83f5=n4zr6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 January 2018 at 11:41, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Wed, Jan 10, 2018 at 12:11:35PM +0000, Ard Biesheuvel wrote:
>> Prevent inadvertently creating speculative gadgets by moving literal data
>> into the .rodata section.
>>
>> Patch #1 enables this for C code, by reverting a change that disables the
>> GCC feature implementing this. Note that this conflicts with the mitigation
>> of erratum #843419 for Cortex-A53.
>
> Ard, which tree is this supposed to go through?
>

Hi Herbert,

I am going to drop that first patch, the remaining 6 patches can go
through the crypto tree as they are independent.

Thanks,
Ard.
