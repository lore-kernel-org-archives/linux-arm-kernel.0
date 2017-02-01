From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2017 13:57:00 +0100
Subject: [GIT PULL] Ux500 devicetree changes for v4.11
In-Reply-To: <1507979.mEcWZWFyc4@wuerfel>
References: <CACRpkdbOrFAgOn_vr8vLc9pGHqzkm+Os9MrhxJjs0xxzMHO+Og@mail.gmail.com>
 <1507979.mEcWZWFyc4@wuerfel>
Message-ID: <CACRpkdaX0QHHZ5i8LSVacuYpBDQS_Rm+6RprEzbL89LttnhUxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 10:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, February 1, 2017 10:29:30 AM CET Linus Walleij wrote:
>> Hi ARM SoC people,
>>
>> sorry for the late pull request, but these really should be going to
>> 4.11. As late or whatever is fine.
>>
>> I found a number of bugs in the platform that had been accumulating
>> and it would be nice to iron out most of them in v4.11.
>>
>> Please pull this to the ARM SoC tree in some apropriate branch.
>>
>> Yours,
>> Linus Walleij
>>
>> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
>>
>>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
>> tags/ux500-dt-1
>>
>> for you to fetch changes up to 3015d3b05239e33b42b1ae9ac408cc60fa4772ce:
>>
>>   ARM: dts: add the AB8500 sysclk to the device trees (2017-01-31
>> 22:15:06 +0100)
>>
>> ----------------------------------------------------------------
>> Ux500 Device Tree updates for v4.11:
>>
>> This cleans the device tree a bit and rectifies some
>> clocking bugs. They are in a sense regressions, but there
>> is no hurry for this platform.
>
> This is what the kbuild bot found for the patch submission:
>
>>> arch/arm/boot/dts/ste-dbx5x0.dtsi:17:42: fatal error: dt-bindings/clock/ste-ab8500.h: No such file or directory
>
> Can you have a look what caused it?

That is not for any of the patches in this pull request.

The build bot grabbed the whole branch including a patch named
"ARM: dts: add the AB8500 clocks to the device tree"
that I also posted, and which indeed has this problem.
(Because of pending changes in the clk subsystem.)

But this pull request does not feature that patch. It includes
everything except that patch, exactly because I couldn't
fix the above dependency.

Of course I could start messing with immutable branches
between clk and arm-soc but I think that is too bureaucratic
at this point. It can just wait for v4.12.

Yours,
Linus Walleij
