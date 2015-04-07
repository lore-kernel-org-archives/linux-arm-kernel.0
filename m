From: mmarek@suse.cz (Michal Marek)
Date: Tue, 07 Apr 2015 13:19:58 +0200
Subject: [PATCH 0/2] Kbuild: kallsyms: update suffix ignore logic
In-Reply-To: <CAKv+Gu-HkK96hz7zKQeJfeh2YiRY+qGaWkQdrSn0=n+P0qeHZQ@mail.gmail.com>
References: <1427721632-11665-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu-HkK96hz7zKQeJfeh2YiRY+qGaWkQdrSn0=n+P0qeHZQ@mail.gmail.com>
Message-ID: <5523BD5E.8000300@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 7.4.2015 v 11:02 Ard Biesheuvel napsal(a):
> On 30 March 2015 at 15:20, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Two patches that update the kallsyms ignore logic.
>>
>> Patch #1 adds logic to introduce symbols whose names end in (or equal)
>> "_veneer". This prevent kallsyms generation errors on large ARM kernels
>> where the emitted veneers will be different between the first and second
>> pass, due to the fact that the size of the kallsyms region itself pushes
>> the .text and .init.text sections further apart during the second pass.
>>
>> Patch #2 removes the handling of the "gcc[0-9]_compiled." symbol. It was
>> only ever emitted by GCC v2.x which we don't support anymore anyway.
>>
>> This series is a followup to ' [RFC PATCH 0/2] ARM large kernels'
>> (http://thread.gmane.org/gmane.linux.kbuild.devel/13065), but the
>> other issue addressed by patch #2 of that series will be deferred
>> for now.
>>
>> Ard Biesheuvel (2):
>>   Kbuild: kallsyms: ignore veneers emitted by the ARM linker
>>   Kbuild: kallsyms: drop special handling of pre-3.0 GCC symbols
>>
>>  scripts/kallsyms.c | 29 ++++++++++++++++++++---------
>>  1 file changed, 20 insertions(+), 9 deletions(-)
>>
> 
> Ping?

Applied to kbuild.git#kbuild.

Michal
