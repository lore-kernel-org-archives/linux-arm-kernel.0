From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Jan 2018 12:01:01 +0000
Subject: [PATCH] efi/arm*: Only register page tables when they exist
In-Reply-To: <20180117101922.GB27892@arm.com>
References: <20180116140832.26731-1-mark.rutland@arm.com>
 <20180117101922.GB27892@arm.com>
Message-ID: <CAKv+Gu_xB2XywijC0VMY48uR212pOnm7dFzOAp2ozevHC7fRSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 January 2018 at 10:19, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jan 16, 2018 at 02:08:32PM +0000, Mark Rutland wrote:
>> Currently the arm/arm64 runtime code registers the runtime servies
>> pagetables with ptdump regardless of whether runtime services page
>> tables have been created.
>>
>> As efi_mm.pgd is NULL in these cases, attempting to dump the efi page
>> tables results in a NULL pointer dereference in the ptdump code:
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> Ard -- please can you pick this one up?
>

I'll see if I can manage applying it.

-- 
Ard.
