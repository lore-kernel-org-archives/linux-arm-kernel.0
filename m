From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Jun 2014 16:54:00 +0200
Subject: [PATCH] arm64/crypto: fix and improve GHASH secure hash
 implementation
In-Reply-To: <20140612144847.GC8970@arm.com>
References: <1402584187-17114-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140612144847.GC8970@arm.com>
Message-ID: <CAKv+Gu950YjVtQQ3fST-h3bUy+qAoQv=hBRoe0ekaxADGNK4ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 June 2014 16:48, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Jun 12, 2014 at 03:43:07PM +0100, Ard Biesheuvel wrote:
>> This fixes a bug in the arm64 GHASH implementation, and switches to a faster,
>> polynomial multiplication based reduction instead of one that uses
>> shifts and rotates.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> This is a bug fix and a performance optimization in a single patch.
>
> Thanks. I'll push it after -rc1.
>
>> As the code has never worked correctly and was merged just a couple of
>> days ago,
>
> IIRC you said you tested the crypto patches.
>

Yes, I did. Unfortunately [as I found out today] the built-in test
suite for GHASH consists of a single test vector, which happens to
pass with the old code. I will be submitting a patch to linux-crypto
shortly to add more test vectors that would have caught this
particular bug.

-- 
Ard.
