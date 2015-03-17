From: keescook@chromium.org (Kees Cook)
Date: Tue, 17 Mar 2015 08:19:20 -0700
Subject: [PATCH v4 03/10] arm64: standardize mmap_rnd() usage
In-Reply-To: <20150317144702.GN8399@arm.com>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
 <1425503454-7531-4-git-send-email-keescook@chromium.org>
 <20150317144702.GN8399@arm.com>
Message-ID: <CAGXu5jKHPL1V81wQ-gLAmGeMD9miM73X-QAL_RHbt+6hAEaAKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 7:47 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Mar 04, 2015 at 09:10:47PM +0000, Kees Cook wrote:
>> In preparation for splitting out ET_DYN ASLR, this refactors the use of
>> mmap_rnd() to be used similarly to arm and x86. This additionally enables
>> mmap ASLR on legacy mmap layouts, which appeared to be missing on arm64,
>> and was already supported on arm. Additionally removes a copy/pasted
>> declaration of an unused function.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/arm64/include/asm/elf.h |  1 -
>>  arch/arm64/mm/mmap.c         | 18 +++++++++++-------
>>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> Looks fine to me:
>
>   Acked-by: Will Deacon <will.deacon@arm.com>
>
> Do you want me to pick this up, or are you taking it along with the rest of
> your series (it doesn't have any obvious dependencies to me)?

Thanks! Right now akpm is carrying it, since the series ends with
changes that depend on all the per-arch refactoring.

-Kees

-- 
Kees Cook
Chrome OS Security
