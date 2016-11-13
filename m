From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 13 Nov 2016 21:05:18 +0000
Subject: [PATCH v3] crypto: arm64/sha2: integrate OpenSSL implementations
 of SHA256/SHA512
In-Reply-To: <c8306030-d4eb-fea7-441a-3476cd308496@openssl.org>
References: <1478953953-11523-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161112221520.GD24127@arm.com>
 <CAKv+Gu_Y-ik0L9mh4z-g3fHKjPt780_znCQNU-jAwXifLgAo4A@mail.gmail.com>
 <c8306030-d4eb-fea7-441a-3476cd308496@openssl.org>
Message-ID: <CAKv+Gu8ouGT31ZqtiX5dFk-QnezjdNHOnP9ErbTDg70tVUU+YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2016 at 15:12, Andy Polyakov <appro@openssl.org> wrote:
>> (+ Andy)
>>
>> ...
>>>
>>> Looking at the generated code, I see references to __ARMEB__ and
>> __ILP32__.
>>> The former is probably a bug,
>
> Oh! You mean that it should be __AARCH64EB__/__AARCH64EL__!

Indeed:

$ aarch64-linux-gnu-gcc -dM -E  - <<<""   |grep AARCH
#define __AARCH64_CMODEL_SMALL__ 1
#define __AARCH64EL__ 1

$ aarch64-linux-gnu-gcc -dM -E -mbig-endian - <<<""   |grep AARCH
#define __AARCH64_CMODEL_SMALL__ 1
#define __AARCH64EB__ 1

-- 
Ard.
