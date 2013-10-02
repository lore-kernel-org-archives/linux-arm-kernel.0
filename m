From: matthew_minter@xyratex.com (Matthew Minter)
Date: Wed, 2 Oct 2013 16:55:25 +0100
Subject: Armada XP doesn't boot in v3.12-rc3
In-Reply-To: <20131002124320.GL31178@titan.lakedaemon.net>
References: <CAFJTrDvNYa2g-TFPjii5WpCgnX8kc8r9v3+jzL7gkHCwRV-obg@mail.gmail.com>
 <20131002124320.GL31178@titan.lakedaemon.net>
Message-ID: <CAFJTrDsTmSzFEX7XVqnw4=vYiBdqNeLDQuWFotSEZqGsFxT9sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for the reply.

To give a little background the box is a Marvell DB-MV784MP-GP.
It also appears that it is a revision B0 which various materials seem
to imply matters but I am not sure of the significance.

I have tried a number of configurations including the defaults for the
mach and various settings including turning CONFIG_HAVE_ARM_ARCH_TIMER
on and off.

Some configurations result in no output after uBoot's booting kernel
line, but some reach theline "calibrating timer loop" then hang
indefinitely.

I am now trying the fixes branch at
git://git.infradead.org/linux-mvebu.git (thanks Ezequiel) to see if
that contains a solution. Once I have tried that I shall see what
changes it made and mail back any results. (I am talking to the board
down a serial over USB connection so can get a fair amount of
diagnostics from the early printk system).

Best regards,
Matthew

On 2 October 2013 13:43, Jason Cooper <jason@lakedaemon.net> wrote:
> On Wed, Oct 02, 2013 at 11:39:53AM +0100, Matthew Minter wrote:
>> Hi,
>>
>> I am having the same issue as
>> "Re: mvebu: Armada XP doesn't boot in v3.12-rc1".
>> except that I am running rc3.
>>
>> I am wondering if the mentioned patch was ever released as I currently
>> have an un-bootable board.
>
> Yes, it's:
>
>   7b0dd72 arm: clocksource: mvebu: Use the main timer as clock source from DT
>
> which made it into v3.12-rc3.
>
> We'll need more information in order to diagnose your problem.  You've
> either stumbled across a different problem, or need to try a clean
> build.  But I'm just guessing since I'm not in front of your box ;-)
>
> hth,
>
> Jason.

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
