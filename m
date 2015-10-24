From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 24 Oct 2015 04:29:05 +0200
Subject: [PATCH] arm64: Align .text section to PAGE_SIZE
In-Reply-To: <562A78B8.3000503@arm.com>
References: <1445610134-20528-1-git-send-email-jeremy.linton@arm.com>
 <CAKv+Gu_5YPiQOejsAUdVs7YbNJD4tFwuATYq6VNxuXbeRsoYkw@mail.gmail.com>
 <562A610F.4090101@arm.com>
 <CAKv+Gu_QKpL2X3ZNn9QVZnBa00JrF1v0W1DtkyuGzm1cLREPWg@mail.gmail.com>
 <562A78B8.3000503@arm.com>
Message-ID: <CAKv+Gu-TJgMmFtM2zXWArfZZg=dGXR6Q797W_roogL+Hm+fV=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Laura, correct email this time)

http://thread.gmane.org/gmane.linux.ports.arm.kernel/450513

On 23 October 2015 at 20:13, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 10/23/2015 11:49 AM, Ard Biesheuvel wrote:
>>
>> On 23 October 2015 at 18:32, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> ...
>>>
>>>          Maybe a clearer fix is an additional ifdef in the
>>> DEBUG_ALIGN_RODATA
>>> stanza which sets ALIGN_DEBUG_RO to align to pagesize if DEBUG_RODATA is
>>> set, that way it only takes affect for RODATA.
>>
>>
>> I think the diff does what you mean here.
>
> ...
>
> This solves the problem I have. But, my comment about was trying to be a
> little more creative and allow it to align at less than page size if
> DEBUG_RODATA isn't set, as it does today. Sort of a packed kernel if you
> will...
>

OK, I didn't catch that. Not sure if the average waste of 32 KB is
worth the trouble, though. Especially since, in my opinion,
CONFIG_DEBUG_RODATA should be promoted to a non-debug 'default y'
option.

-- 
Ard.

> But I will re-post shortly with just the ALIGN_DEBUG_RO change you suggest.
>
> Thanks,
>
>
