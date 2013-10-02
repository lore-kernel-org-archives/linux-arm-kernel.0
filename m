From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 2 Oct 2013 18:07:02 +0200
Subject: Armada XP doesn't boot in v3.12-rc3
In-Reply-To: <CAFJTrDsTmSzFEX7XVqnw4=vYiBdqNeLDQuWFotSEZqGsFxT9sA@mail.gmail.com>
References: <CAFJTrDvNYa2g-TFPjii5WpCgnX8kc8r9v3+jzL7gkHCwRV-obg@mail.gmail.com>
 <20131002124320.GL31178@titan.lakedaemon.net>
 <CAFJTrDsTmSzFEX7XVqnw4=vYiBdqNeLDQuWFotSEZqGsFxT9sA@mail.gmail.com>
Message-ID: <20131002180702.702ce17b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Matthew Minter,

On Wed, 2 Oct 2013 16:55:25 +0100, Matthew Minter wrote:

> To give a little background the box is a Marvell DB-MV784MP-GP.
> It also appears that it is a revision B0 which various materials seem
> to imply matters but I am not sure of the significance.

I don't remember which version of the SoC we have here, but I can check
this tomorrow. Also, which U-Boot version do you have on this machine?

> I have tried a number of configurations including the defaults for the
> mach and various settings including turning CONFIG_HAVE_ARM_ARCH_TIMER
> on and off.
> 
> Some configurations result in no output after uBoot's booting kernel
> line, but some reach theline "calibrating timer loop" then hang
> indefinitely.

The first case means the kernel really doesn't boot. It can be due to
an incorrect earlyprintk configuration, for example (but also other
things).

The second case is due to the timer being broken, which normally the
patches pointed by Ezequiel should be fixing.

> I am now trying the fixes branch at
> git://git.infradead.org/linux-mvebu.git (thanks Ezequiel) to see if
> that contains a solution. Once I have tried that I shall see what
> changes it made and mail back any results. (I am talking to the board
> down a serial over USB connection so can get a fair amount of
> diagnostics from the early printk system).

It's a shame that 3.12-rc still isn't fixed, and that 3.12-rc1 was
broken in the first place :/ We used to be quite good at having at
least bootable quality even at -rc1 stage, and many people and
reporting problems now that 3.12-rc1 doesn't even boot on Armada 370/XP.

Ezequiel, Jason, can you ping the relevant maintainers to make sure the
relevant patches are merged quickly and land in the next -rc?

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
