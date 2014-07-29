From: jussi.kivilinna@iki.fi (Jussi Kivilinna)
Date: Tue, 29 Jul 2014 19:23:51 +0300
Subject: [PATCH] [v3] crypto: sha512: add ARM NEON implementation
In-Reply-To: <CAKv+Gu8R3oOgLohf+tCmuGEny7PSBd6HYgysEJtOrW-XWE9mMA@mail.gmail.com>
References: <20140630163928.1362.41900.stgit@localhost6.localdomain6>
 <CAKv+Gu8R3oOgLohf+tCmuGEny7PSBd6HYgysEJtOrW-XWE9mMA@mail.gmail.com>
Message-ID: <53D7CA97.2040901@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.07.2014 15:35, Ard Biesheuvel wrote:
> On 30 June 2014 18:39, Jussi Kivilinna <jussi.kivilinna@iki.fi> wrote:
>> This patch adds ARM NEON assembly implementation of SHA-512 and SHA-384
>> algorithms.
>>
>> tcrypt benchmark results on Cortex-A8, sha512-generic vs sha512-neon-asm:
>>
>> block-size      bytes/update    old-vs-new
>> 16              16              2.99x
>> 64              16              2.67x
>> 64              64              3.00x
>> 256             16              2.64x
>> 256             64              3.06x
>> 256             256             3.33x
>> 1024            16              2.53x
>> 1024            256             3.39x
>> 1024            1024            3.52x
>> 2048            16              2.50x
>> 2048            256             3.41x
>> 2048            1024            3.54x
>> 2048            2048            3.57x
>> 4096            16              2.49x
>> 4096            256             3.42x
>> 4096            1024            3.56x
>> 4096            4096            3.59x
>> 8192            16              2.48x
>> 8192            256             3.42x
>> 8192            1024            3.56x
>> 8192            4096            3.60x
>> 8192            8192            3.60x
>>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Jussi Kivilinna <jussi.kivilinna@iki.fi>
>>
>> ---
>>
>> Changes in v2:
>>  - Use ENTRY/ENDPROC
>>  - Don't provide Thumb2 version
>>
>> v3:
>>  - Changelog moved below '---'
> 
> Hi Jussi,
> 
> What is the status of these patches?
> Have you sent them to Russell's patch tracker?
>

I sent them to patch tracker moment ago. Thanks for the reminder.

-Jussi
