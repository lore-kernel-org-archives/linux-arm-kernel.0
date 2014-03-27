From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 27 Mar 2014 15:20:17 +0100
Subject: [PATCH] arm64: add appropriate asm/unaligned.h
In-Reply-To: <CAL_JsqLyZG+z+SNy+++pJ15WeWbTFgDRTfOE9j66wE9kX0F9-g@mail.gmail.com>
References: <1395927591-20938-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAL_JsqLyZG+z+SNy+++pJ15WeWbTFgDRTfOE9j66wE9kX0F9-g@mail.gmail.com>
Message-ID: <CAKv+Gu9H1OpyMuRORaOfCDmZjj792PgZRSG+X4rdDOveT9jeug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 March 2014 15:15, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Mar 27, 2014 at 8:39 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> The generic asm/unaligned.h does not allow unaligned accesses, resulting in all
>> invocations of get_unaligned_xxx() and put_unaligned_xxx() to be expanded into
>> byte size accesses. On arm64, this is unnecessary, so provide a more permissive
>> asm/unaligned.h instead.
>
> Couldn't the generic version learn to use
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS on arches that enable it?
>

I wasn't aware of that option, but I agree that it seems reasonable to
test for that in the asm-generic version.

-- 
Ard.
