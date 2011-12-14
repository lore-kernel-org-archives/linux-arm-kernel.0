From: govindraj.ti@gmail.com (Govindraj)
Date: Wed, 14 Dec 2011 14:16:41 +0530
Subject: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
In-Reply-To: <87fwgow9vz.fsf@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
 <CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
 <87fwgow9vz.fsf@ti.com>
Message-ID: <CAAL8m4wR-3WDYf_c56-h1ZtCg=Ob2T+FvOOaXLSKK1pyo9oh8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 12:56 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
> [...]
>
>> I have re-based this patch series against LO master
>> commit id: deee6d5359969a0ce4e2760cfd7b9f379bd5698a
>>
>> Same is available here [1]
>>
>> I have tested this patch series along with:
>>
>> 1.) Tero's V11 irq chaining series
>> ? ? ?http://www.spinics.net/lists/linux-omap/msg61445.html
>> ? ? (This patch series is used for uart wakeup handling using
>> ? ? ? prcm_irq chaining)
>>
>> 2.) Rajendra's hwmod change
>> ? ? ?http://www.spinics.net/lists/arm-kernel/msg148632.html
>> ? ? ?(This patch handles init_no_idle flag setting
>> ? ? ? without this patch there will be boot warning however
>> ? ? ? all pm features will work after boot up.)
>>
>> 3.) Vishwa's io daisy chain changes.
>> ? ? ?http://permalink.gmane.org/gmane.linux.ports.arm.omap/65500
>> ? ? ?(tested with and without this patch series pm features works).
>>
>> Same combination of patches based on above commit id
>> used for testing is available here [2].
>
> Please have a closer look at your branch.
>
> The second commit[1] commits the .rej file from a failed patch apply,
> so obviously doesn't do what was intended.
>

Sorry my bad I have refreshed the uart runtime branch [1]
& test branch [2].

stat for uart patches for the both the branches as here [3]

--
Thanks,
Govindraj.R

[1]:
git://gitorious.org/runtime_3-0/runtime_3-0.git
for_3_3/lo_rc4_uartruntime

[2]:
git://gitorious.org/runtime_3-0/runtime_3-0.git
for_3_3/tmp_rc4_uart_pm_intg

[3]:
<<uart runtime branch>>

ubnuser at ula0131859:~/clones/runtime_3-0$ git diff --stat deee6d5
 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |   68 +--
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |   68 +--
 arch/arm/mach-omap2/cpuidle34xx.c             |    6 -
 arch/arm/mach-omap2/pm24xx.c                  |   20 -
 arch/arm/mach-omap2/pm34xx.c                  |   43 --
 arch/arm/mach-omap2/serial.c                  |  907 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   37 +-
 arch/arm/plat-omap/include/plat/serial.h      |   10 +-
 drivers/tty/serial/omap-serial.c              |  343 ++++++++--
 11 files changed, 584 insertions(+), 1024 deletions(-)

<<tmp_intg_test branch>>

ubnuser at ula0131859:~/clones/runtime_3-0$ git diff --stat deee6d5..aad8423
 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |   68 +--
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |   68 +--
 arch/arm/mach-omap2/cpuidle34xx.c             |    6 -
 arch/arm/mach-omap2/pm24xx.c                  |   20 -
 arch/arm/mach-omap2/pm34xx.c                  |   43 --
 arch/arm/mach-omap2/serial.c                  |  907 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   37 +-
 arch/arm/plat-omap/include/plat/serial.h      |   10 +-
 drivers/tty/serial/omap-serial.c              |  343 ++++++++--
 11 files changed, 584 insertions(+), 1024 deletions(-)
