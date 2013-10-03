From: matthew_minter@xyratex.com (Matthew Minter)
Date: Thu, 3 Oct 2013 10:41:07 +0100
Subject: Armada XP doesn't boot in v3.12-rc3
In-Reply-To: <20131002202547.GA10645@localhost>
References: <CAFJTrDvNYa2g-TFPjii5WpCgnX8kc8r9v3+jzL7gkHCwRV-obg@mail.gmail.com>
 <20131002124320.GL31178@titan.lakedaemon.net>
 <CAFJTrDsTmSzFEX7XVqnw4=vYiBdqNeLDQuWFotSEZqGsFxT9sA@mail.gmail.com>
 <20131002202547.GA10645@localhost>
Message-ID: <CAFJTrDsiOfG1rNWo3OXtzdcquP8kdS+_x2YYELOQDH96SLGm_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It seems the latest build of "for-next" from
git://git.infradead.org/linux-mvebu.git works the charm.
For reference I have a version of uBoot that came with the board, I am
reluctant to reflash it as I would then have no way of recovering and
it has not seemed to cause any issues anyway. (the only drawback is
that it seems to prefer to appended dtb image and not explicit
passing).

The version is as follows but is likely not useful as it seems to be a
build customised for the hardware, it does support uImages and the new
format however:

U-Boot 2011.12-00036-g664db9a-dirty (Oct 16 2012 - 14:12:23) Marvell
version: 2012_Q4.1

I am still working through some small driver issues (trying to mount
various SSDs) but the early boot failure is resolved with those
patches and the default configuration (plus early printk).

Thank you all so much for the help, I think this board is now working
fine but will report any other issues I come across later.

Best regards,
Matthew

On 2 October 2013 21:25, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Hi Matthew:
>
> On Wed, Oct 02, 2013 at 04:55:25PM +0100, Matthew Minter wrote:
> [...]
>>
>> I have tried a number of configurations including the defaults for the
>> mach and various settings including turning CONFIG_HAVE_ARM_ARCH_TIMER
>> on and off.
>>
>> Some configurations result in no output after uBoot's booting kernel
>> line, but some reach theline "calibrating timer loop" then hang
>> indefinitely.
>>
>
> Yup, that's the two different bugs the patches should fix.
>
>> I am now trying the fixes branch at
>> git://git.infradead.org/linux-mvebu.git (thanks Ezequiel) to see if
>> that contains a solution. Once I have tried that I shall see what
>> changes it made and mail back any results. (I am talking to the board
>> down a serial over USB connection so can get a fair amount of
>> diagnostics from the early printk system).
>>
>
> Please test git://git.infradead.org/linux-mvebu.git or some recent
> linux-next. You should be able to boot with/without CONFIG_HAVE_ARM_ARCH_TIMER.
>
> I expect all the fixes land in -rc4, which means mainline should be
> fixed by next week.
>
> Let me know any problems!
>
> Thanks a lot for reporting!
>
> --
> Ezequiel Garc?a, Free Electrons
> Embedded Linux, Kernel and Android Engineering
> http://free-electrons.com

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
