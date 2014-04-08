From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 8 Apr 2014 08:48:44 +0200
Subject: [PATCH] asm-generic: allow generic unaligned access if the arch
 supports it
In-Reply-To: <20140331095941.GA29871@arm.com>
References: <1395942387-14177-1-git-send-email-ard.biesheuvel@linaro.org>
 <201403281914.20201.arnd@arndb.de>
 <CAKv+Gu_9yD1jWhxkPxSUbwjJk4QxPNXBR=EXfmfCgzD1Pdig2g@mail.gmail.com>
 <20140331095941.GA29871@arm.com>
Message-ID: <CAKv+Gu-rx8W05i=xHaoZCktj6YWH56Zn2yNaiEeenm0=NmcwUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 March 2014 11:59, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Mar 28, 2014 at 06:24:04PM +0000, Ard Biesheuvel wrote:
>> On 28 March 2014 19:14, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 27 March 2014, Ard Biesheuvel wrote:
>> >> Switch the default unaligned access method to 'hardware implemented'
>> >> if HAVE_EFFICIENT_UNALIGNED_ACCESS is set.
>> >>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >
>> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>> >
>> > Is this part of a longer series of patches? If so, please keep
>> > the patch with the others and merge it through an appropriate
>> > tree.
>> >
>>
>> No, not really. I ran into the alignment issue while working on the
>> arm64 crypto stuff, but it is unclear when that will be going in.
>>
>> > If not, I guess I'll have to send it myself, but it will be
>> > the only asm-generic patch for the merge window ;-)
>>
>> Perhaps Catalin is interested in taking it, as arm64 is the only arch
>> that defines HAVE_EFFICIENT_UNALIGNED_ACCESS /and/ uses the
>> asm-generic version of unaligned.h.
>>
>> @Catalin?
>>
>> http://marc.info/?l=linux-arch&m=139594237116121&w=2
>
> I can take this, providing it doesn't break anything else. I'll push it
> to -next but won't send it with the first arm64 pull request.
>

Are you still interested in taking this? Russell doesn't appear
particularly unhappy with it, so I guess it should sit in -next for a
bit before getting it merged.

-- 
Ard.
