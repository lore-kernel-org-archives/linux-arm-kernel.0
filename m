From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 28 Aug 2014 15:39:12 +0200
Subject: [PATCH] ARM: shmobile: Enable Armadillo 800 EVA board in
 multiplatform defconfig
In-Reply-To: <2961349.mXGyF0dyBP@wuerfel>
References: <1409229622-11566-1-git-send-email-geert+renesas@glider.be>
 <3285079.8x1UeyRQTp@wuerfel>
 <CAMuHMdVQLny1u7SxNvN+jNHSGNfFUPL=fvx8oDgO1EkhZBp8pA@mail.gmail.com>
 <2961349.mXGyF0dyBP@wuerfel>
Message-ID: <CAMuHMdXiCdPhMAUx88Rx6hbrZtOZiN8z=GkN_exT5+Vjj0rF9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Aug 28, 2014 at 3:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 August 2014 15:06:31 Geert Uytterhoeven wrote:
>> On Thu, Aug 28, 2014 at 2:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > No objections to the patch, but I wonder if you could send another
>> > patch to enable all the machines working in ARCH_SHMOBILE_MULTI
>> > as part of multi_v7_defconfig as well.
>>
>> Sure. I actually have such a patch lying around
>>
>> I've just added armadillo support there, too, but it hangs during boot
>> on Armadillo. May be that the image is just too big for the Hermit boot
>> loader.
>> It does work on Koelsch. Haven't tried it yet on BeagleBone Black, though.
>>
>> Do you want it? Or do you want the version without armadillo support?
>
> Good question. Ideally I'd like them all to be enabled, but I guess there
> is little value in adding Armadillo if it doesn't actually work.
>
> Maybe you have run into the same u-boot problem that a few other people
> had before? When mach-qcom is enabled, the kernel entry point changes
> and you have to adapt any script that tries to build a uImage manually.

Armadillo uses hermit, not u-boot, and boots a zImage with appended DTB.
I tried disabling CONFIG_ARCH_QCOM, but it didn't make a difference.
It does boot the shmobile_defconfig kernel, which is only 3 MiB large
(compared to 5.4 for multi_v7_defconfig).

For now, I'll send you the version without armadillo support.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
