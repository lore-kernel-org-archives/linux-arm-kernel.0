From: olof@lixom.net (Olof Johansson)
Date: Thu, 16 Jul 2015 11:48:10 -0700
Subject: [PATCH] arm64: enable more compressed Image formats
In-Reply-To: <20150716183750.GW26390@arm.com>
References: <1437069852-8393-1-git-send-email-olof@lixom.net>
 <20150716183750.GW26390@arm.com>
Message-ID: <CAOesGMgEcapbjbU4vSB-v1jhgSEhWwrKJpG70hrunB1YtHSwNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 11:37 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Olof,
>
> On Thu, Jul 16, 2015 at 07:04:12PM +0100, Olof Johansson wrote:
>> Plumb up Makefile arguments for the already supported formats in the kbuild
>> system: lz4, bzip2, lzma, and lzo.
>>
>> Note that just as with Image.gz, these images are not self-decompressing and
>> the booting firmware still needs to handle decompression before launching the
>> kernel image.
>
> No conceptual issues with this, but it breaks my build:
>
>   arch/arm64/Makefile:61: *** mixed implicit and normal rules: deprecated syntax
>   arch/arm64/Makefile:61: *** mixed implicit and normal rules: deprecated syntax
>   arch/arm64/Makefile:61: *** mixed implicit and normal rules: deprecated syntax
>   arch/arm64/Makefile:61: *** mixed implicit and normal rules: deprecated syntax
>   make[1]: *** No rule to make target 'Image.gz', needed by 'all'.  Stop.
>   make[1]: *** Waiting for unfinished jobs....
>   make: *** [sub-make] Error 2
>
> I hear some people run auto-builders nowaways that might spot this ;)

Huh. Worked on my manual build. Will respin.


-Olof
