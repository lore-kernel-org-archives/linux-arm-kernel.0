From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 23 Oct 2015 13:13:12 -0500
Subject: [PATCH] arm64: Align .text section to PAGE_SIZE
In-Reply-To: <CAKv+Gu_QKpL2X3ZNn9QVZnBa00JrF1v0W1DtkyuGzm1cLREPWg@mail.gmail.com>
References: <1445610134-20528-1-git-send-email-jeremy.linton@arm.com>
 <CAKv+Gu_5YPiQOejsAUdVs7YbNJD4tFwuATYq6VNxuXbeRsoYkw@mail.gmail.com>
 <562A610F.4090101@arm.com>
 <CAKv+Gu_QKpL2X3ZNn9QVZnBa00JrF1v0W1DtkyuGzm1cLREPWg@mail.gmail.com>
Message-ID: <562A78B8.3000503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2015 11:49 AM, Ard Biesheuvel wrote:
> On 23 October 2015 at 18:32, Jeremy Linton <jeremy.linton@arm.com> wrote:
...
>>          Maybe a clearer fix is an additional ifdef in the DEBUG_ALIGN_RODATA
>> stanza which sets ALIGN_DEBUG_RO to align to pagesize if DEBUG_RODATA is
>> set, that way it only takes affect for RODATA.
>
> I think the diff does what you mean here.
...

This solves the problem I have. But, my comment about was trying to be a 
little more creative and allow it to align at less than page size if 
DEBUG_RODATA isn't set, as it does today. Sort of a packed kernel if you 
will...

But I will re-post shortly with just the ALIGN_DEBUG_RO change you suggest.

Thanks,
