From: olof@lixom.net (Olof Johansson)
Date: Sun, 7 Oct 2012 11:21:34 -0700
Subject: [PATCH 0/4] arm-soc: vt8500: Cleanup patches for 3.7
In-Reply-To: <1349633692.9507.7.camel@gitbox>
References: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
 <201210071123.39535.arnd@arndb.de> <1349633692.9507.7.camel@gitbox>
Message-ID: <CAOesGMg-x0=30BY46RmUiMNhMHe_2ezNRzw7oEBkn21PS=E3Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 7, 2012 at 11:14 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> On Sun, 2012-10-07 at 11:23 +0000, Arnd Bergmann wrote:
>> On Sunday 07 October 2012, Tony Prisk wrote:
>> > Minor cleanup patches for 3.7.
>> >
>> > Tony Prisk (4):
>> >   vt8500: Remove unused headers from include/mach/
>> >   vt8500: Remove arm/boot/compressed/head-vt8500.S
>> >   vt8500: Fix header in mach-vt8500/timer.c
>> >   vt8500: Fix build warning when no framebuffer selected
>>
>> Hi Tony,
>>
>> The patches all look good, but they are late for 3.7 now. I would
>> still take the last one since that fixes a build warning, and the
>> separate patch that adds the .dtb files to the Makefile, but leave
>> the other ones for 3.8, unless there is a strong reason to
>> still include them.
>>
>>       Arnd
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> Just to clarify,
>
> Is it only bug-fixes, not cleanup that are being accepted during the
> merge-window?

During the merge window, code goes in from the maintainer trees into
Linus' tree. So code you want included in the next merge window should
be in arm-soc before the window starts. So per definition, if you send
_us_ code during the merge window then yes, it should be bugfixes.

Bugfixes can go in through the rest of the release cycle. As we go
further down the -rcs, we will get pickier on what bugfixes we let in,
but during the first rc or so, we're a bit more flexible. After that,
mostly regression fixes, etc -- if something has been broken for two
years, there's no urgent need to get it into the very last -rc in many
cases, for example.


-Olof
