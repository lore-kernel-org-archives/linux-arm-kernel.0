From: dsaxena@plexity.net (Deepak Saxena)
Date: Sat, 29 Oct 2011 00:14:55 +0200
Subject: [PATCH 00/51] Remove inline arch_reset definitions from system.h
In-Reply-To: <20111028220821.GA27661@plexity.net>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<20111028220821.GA27661@plexity.net>
Message-ID: <CAC4N5EOnhfRFFqJ5Hbi3+1g8Ee8To2m833OjhdxBonJ1Y8v2UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2011 at 12:08 AM, Deepak Saxena <dsaxena@plexity.net> wrote:
> On Oct 28 2011, at 15:43, Will Deacon was caught saying:
>> Well, looks like I finally made it and I reckon I've managed to preserve
>> my sanity.
>>
>> This patch series removes the inline arch_reset definitions from the
>> mach/system.h files, which is currently a blocker for the single zImage
>> work. Nicolas has some patches doing a similar thing for arch_idle. In
>> cases where a new file has been introduced and it looks like arch_idle
>> could co-exist in there, I've named the new file system.c but it will
>> mean that Nicolas will need to rebase his stuff on top of this.
>>
>> I think I've compile-tested this whenever I could identify the right
>> defconfig, but my brain stopped working about 25% of the way through.
>>
>> Thanks to Paul Walmsley for saving me from the OMAP changes.
>>
>> Comments / suggestions / fixups welcome.
>
> I like the idea, I'm wondering about having stuffing a pointer to
> an init function to assign the pointer into mach_desc? In the at91
> case, we've got 7 board files assiging the same pointer. Instead
> we could just have an at91_arch_reset_init() that only needs
> to be in one .c file.

/ignore me. I missread the patch and though they were all being assigned
to the same function.

> Another idea is to just stuff the pointer to the machine's arch_reset
> into the mach_desc and generic init code could read it. In the case
> of a some weird board version related quirk that can only be detected
> by some runtime register poking (i.e. ?not via the DT machine
> compatability), we could update the pointer in machines' fixup() function.

~Deepak
