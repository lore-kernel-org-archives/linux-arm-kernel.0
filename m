From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Oct 2013 10:40:28 -0700
Subject: [GIT PULL] ARM: provide common arch init for DT clocks for v3.13
In-Reply-To: <20131007165133.GD15413@quad.lixom.net>
References: <1380483490-12173-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131007165133.GD15413@quad.lixom.net>
Message-ID: <CAOesGMg-0-26CuYReEiyJzJu0dS4D4LDpzHw5_CLZwnPfJp7xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 7, 2013 at 9:51 AM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Sep 29, 2013 at 09:38:10PM +0200, Sebastian Hesselbarth wrote:
>> Arnd, Kevin, Olof,
>>
>> please pull these patches for the arch-wide call to of_clk_init for v3.13.
>> There are two dependencies for this patch set, one for tegra and one for nomadik.
>>
>> The pull request for the tegra dependencies can be found here:
>> http://www.spinics.net/lists/arm-kernel/msg273957.html
>>
>> The patch for nomadik, that should hit before v3.13 can be found here:
>> http://www.spinics.net/lists/arm-kernel/msg273376.html
>>
>> As this is my first PR ever, please do not hesitate to report back any issues
>> with this PR as soon as possible.
>
> Thanks, I've merged this in. The only thing missing is a signed tag. I
> stole your description from the 00/26 patch and used that.

I noticed new section mismatches by this branch, please just send an
incremental patch to fix it and I'll apply it on top:

http://arm-soc.lixom.net/buildlogs/arm-soc/v3.12-rc2-206-g5316f70/buildall.arm.nhk8815_defconfig.log.passed

WARNING: drivers/clk/built-in.o(.text.unlikely+0x108): Section
mismatch in reference from the function nomadik_src_init() to the
(unknown reference) .init.rodata:(unknown)
The function nomadik_src_init() references
the (unknown reference) __initconst (unknown).
This is often because nomadik_src_init lacks a __initconst
annotation or the annotation of (unknown) is wrong.


-Olof
