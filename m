From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 May 2015 09:00:49 +0200
Subject: [PATCH 1/2] crypto: arm/sha512 - accelerated SHA-512 using ARM
 generic ASM and NEON
In-Reply-To: <20150511065952.GB2598@gondor.apana.org.au>
References: <1431074782-22141-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150511065952.GB2598@gondor.apana.org.au>
Message-ID: <CAKv+Gu9+xrX2nB43cskOoL63WjZGTDdq9ZTO-maWas5u=ng=JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 May 2015 at 08:59, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, May 08, 2015 at 10:46:21AM +0200, Ard Biesheuvel wrote:
>>
>> diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
>> index 8da2207b0072..08b5fb85bff5 100644
>> --- a/arch/arm/crypto/Kconfig
>> +++ b/arch/arm/crypto/Kconfig
>> @@ -53,20 +53,14 @@ config CRYPTO_SHA256_ARM
>>         SHA-256 secure hash standard (DFIPS 180-2) implemented
>>         using optimized ARM assembler and NEON, when available.
>>
>> -config CRYPTO_SHA512_ARM_NEON
>> -     tristate "SHA384 and SHA512 digest algorithm (ARM NEON)"
>> -     depends on KERNEL_MODE_NEON
>> -     select CRYPTO_SHA512
>> +config CRYPTO_SHA512_ARM
>> +     tristate "SHA-384/512 digest algorithm (ARM-asm and NEON)"
>> +     depends on !CPU_V7M
>>       select CRYPTO_HASH
>> +     depends on !CPU_V7M
>
> This looks like a duplicate, no?

Yes, you are right. Let me figure out what's going on and send you a
new version.
