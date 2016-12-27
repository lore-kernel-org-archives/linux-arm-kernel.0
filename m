From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 27 Dec 2016 14:26:35 +0000
Subject: [PATCH 0/2] crypto: arm64/ARM: NEON accelerated ChaCha20
In-Reply-To: <20161227100400.GA10629@gondor.apana.org.au>
References: <1481207339-17332-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161227100400.GA10629@gondor.apana.org.au>
Message-ID: <6124F827-BA28-4A3D-B05F-EBCB1323955D@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 27 Dec 2016, at 10:04, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
>> On Thu, Dec 08, 2016 at 02:28:57PM +0000, Ard Biesheuvel wrote:
>> Another port of existing x86 SSE code to NEON, again both for arm64 and ARM.
>> 
>> ChaCha20 is a stream cipher described in RFC 7539, and is intended to be
>> an efficient software implementable 'standby cipher', in case AES cannot
>> be used.
>> 
>> This NEON implementation is almost 2x as fast as the generic C code
>> (measured on Cortex-A57 using the arm64 version)
>> 
>> I'm aware that blkciphers are deprecated in favor of skciphers, but this
>> code (like the x86 version) uses the init and setkey routines of the generic
>> version, so it is probably better to port all implementations at once.
>> 
>> Ard Biesheuvel (2):
>>  crypto: arm64/chacha20 - implement NEON version based on SSE3 code
>>  crypto: arm/chacha20 - implement NEON version based on SSE3 code
> 
> Both patches applied.  Thanks.

You just nacked the v2 of this series (due to the chunksize/walksize) and i rewrote them as skciphers as well

> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
