From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Thu, 22 Mar 2012 12:29:56 +0530
Subject: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
In-Reply-To: <87limurpsx.fsf@ti.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
 <87limurpsx.fsf@ti.com>
Message-ID: <CAMrsUdLtC0iVk2qDDDXj2tteAzP5UQJXNvsCoJLEC9Yty2QjvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 7:58 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> Based on Linux-OMAP tree uart branch.
>> (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>> remotes/origin/uart)
>>
>> * Removes the cpu checks wherever possible and use version reg
>> ? for populating features and errata's
>> * enable tx wakeup available in wer reg for applicable
>> ? module revision's
>
> As this affects multiple SoCs, please report what SoCs it was tested on
> as well.

Sorry I for got to add that, here are details on what was tested.

1.) OMAP2430 SDP : Boot tested with uart1 as console.

2.) OMAP3430 SDP: Boot test, suspend/resume tests, retention off mode
                               (checking retention and off mode count
in cpu idle cases)

3.) OMAP3630 - Beagle XM:  Boot test, suspend/resume tests, retention off mode
                                            (checking retention and
off mode count in cpu idle cases)

4.) OMAP4430 - PANDA: Boot test, suspend/resume tests

5.) OMAP4460 - PANDA: Boot test.

--
Thanks,
Govindraj.R


>
> Thanks,
>
> Kevin
>
>> Govindraj.R (3):
>> ? OMAP2+: UART: Remove cpu checks for populating errata flags
>> ? OMAP2+: UART: enable tx wakeup bit for wer reg
>> ? OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx
>>
>> ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ? 13 +----
>> ?arch/arm/plat-omap/include/plat/omap-serial.h | ? ?8 +++-
>> ?drivers/tty/serial/omap-serial.c ? ? ? ? ? ? ?| ? 71 ++++++++++++++++++++++++-
>> ?3 files changed, 78 insertions(+), 14 deletions(-)
