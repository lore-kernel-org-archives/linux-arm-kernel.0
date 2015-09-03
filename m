From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 3 Sep 2015 08:45:32 +0200
Subject: [PATCH] ARM: disable GCC SRA optimization
In-Reply-To: <55E76764.2020200@mentor.com>
References: <1441211290-11449-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_eOQ=ZACn1jzQU-z2ZMqX3PdUx9j05fXuGjniccS2x8Q@mail.gmail.com>
 <55E76764.2020200@mentor.com>
Message-ID: <CAKv+Gu86YFhyQ1RE-ZvKgUhx9q5fM+_8f7sBu9x-cc-ODahPqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 September 2015 at 23:17, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> On 09/02/2015 11:45 AM, Ard Biesheuvel wrote:
>> On 2 September 2015 at 18:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> This is a known but as yet unresolved issue.
>>> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932). In this particular
>>> case, it is causing the second while loop to be executed erroneously a
>>> single time, causing the additional space characters to be printed.
>>>
>>> So disable the optimization by passing -fno-ipa-sra.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>
>>> Needs to go to stable perhaps?
>>> The emitted asm is at the end of this patch.
>>>
>>
>> Another report of the same issue:
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66271
>
> Comments in both bugs indicate that this happens only when building with
> -Os and not -O2.  Have you (or anyone else) been able to get bad code
> with -O2?
>

For me, it occurred with -O2, I did not test -Os in fact. I did
confirm that the problem goes away with -O1

> I don't think the answer should affect the patch itself, but it might be
> kind to note in the commit message whether -Os definitely makes the
> difference here, if this information is known.
>
