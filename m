From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 3 Feb 2018 17:22:32 +0100
Subject: stable-rc build: 2 warnings 0 failures
 (stable-rc/v4.14.13-119-gb32d455)
In-Reply-To: <CAKv+Gu-Jp93gcrzPETrEs9Bba-8K0=1qu0ca=O7SPfCe8mz4ow@mail.gmail.com>
References: <5a5c9ee8.cf53650a.dae00.f369@mx.google.com>
 <CAK8P3a2vXJT1g6wa4cbcDJ48sfOKfemazV0e1crJ5v=6DOZ5fg@mail.gmail.com>
 <CAKv+Gu9ZyXjiKfD6cqEpexdVA_CnYr1kByZJQcKBuK7ig=7MmQ@mail.gmail.com>
 <CAK8P3a2WOhsSM=Ci89s8mDfRKUhUL4M_fLwX0mgQxMjf51iiHQ@mail.gmail.com>
 <CAKv+Gu-Jp93gcrzPETrEs9Bba-8K0=1qu0ca=O7SPfCe8mz4ow@mail.gmail.com>
Message-ID: <CAK8P3a0Haae5bZjqaBunayO1BRx=9tLSNvdGZQvR_UTAB9WF4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 4:22 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 15 January 2018 at 15:17, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, Jan 15, 2018 at 4:08 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 15 January 2018 at 13:38, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Mon, Jan 15, 2018 at 1:30 PM, Olof's autobuilder <build@lixom.net> wrote:
>>>>
>>>>> Warnings:
>>>>>
>>>>>         arm.allmodconfig:
>>>>> /tmp/cccX4oa4.s:18153: Warning: using r15 results in unpredictable behaviour
>>>>> /tmp/cccX4oa4.s:18225: Warning: using r15 results in unpredictable behaviour
>>>>
>>>> This appears to be an old issue that only now started to get reported
>>>> here. From what I can
>>>> tell, new versions of binutils warn about two isntructions in the kprobes test:
>>>>
>>>> Maybe we can work around it using a patch like below?
>>>>
>>>>         Arnd
>>>>
>>>
>>> Can't we just add -Wa,--no-warn for this file?
>>
>> Probably (have not tried). Any reason for preferring one approach over
>> the other?
>> My suggestion for using __inst_arm() was based on that macro already being
>> used a lot in the file, I just don't know if I used it right.
>>
>> If we turn off the warnings, would you change some of the __inst_arm()
>> back intro the proper instructions?
>>
>
> TBH I didn't look at the file before replying. But it appears some of
> the opcodes trigger errors rather than warnings, so we can't get rid
> of all of them. I still think just disabling assembler warnings is
> justified here.

I have not put my patch in Russell's tracker yet, but now that I did
some tests with LTO, the warning has come back, since in the LTO
case, the "-Wa," flags to individual .c files are ignored.

        Arnd
