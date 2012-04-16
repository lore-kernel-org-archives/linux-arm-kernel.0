From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Mon, 16 Apr 2012 12:52:51 +0530
Subject: [GIT PULL]: omap-serial updates for 3.4-rc
In-Reply-To: <CAMrsUdKDhuDLr2=0uiQtY=r4pvmJQo=pJgERRCXySLghO7yGXA@mail.gmail.com>
References: <1334052148-10385-1-git-send-email-govindraj.raja@ti.com>
 <CAMrsUdKDhuDLr2=0uiQtY=r4pvmJQo=pJgERRCXySLghO7yGXA@mail.gmail.com>
Message-ID: <CAMrsUdJ7wzX+Hnx_wBWNnCQz__0sMw8ruFGVWH+x3NGWG0NVQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tue, Apr 10, 2012 at 3:36 PM, Raja, Govindraj <govindraj.raja@ti.com> wrote:
> CC'ing Linux-ARM
>
>
> On Tue, Apr 10, 2012 at 3:32 PM, Govindraj.R <govindraj.raja@ti.com> wrote:
>> Hi Tony,
>>
>> Please Pull the following omap uart changes.
>> Changes basically involves getting rid of cpu checks
>> for populating erratas and features and move the same
>> from serial.c to omap-serial.c, MVR reg is used to find
>> uart versions and errata flags are populated accordingly.

here [1] is the updated pull request I have incorporated even the
serial mux fixes done along with previous changes.

--
Thanks,
Govindraj.R

[1]:

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

  git://gitorious.org/linux-3-x/omap-serial.git for_3.4/uart_fixes

for you to fetch changes up to 32b41c3c98aa652470ca42d1f0be4b558602babb:

  OMAP2+: UART: Add mechanism to probe uart pins and configure rx
wakeup (2012-04-16 12:25:14 +0530)

----------------------------------------------------------------
Govindraj.R (5):
      OMAP2+: UART: Remove cpu checks for populating errata flags
      OMAP2+: UART: enable tx wakeup bit for wer reg
      OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx
      OMAP2+: UART: Fix incorrect population of default uart pads
      OMAP2+: UART: Add mechanism to probe uart pins and configure rx wakeup

 arch/arm/mach-omap2/mux.c                     |    3 +-
 arch/arm/mach-omap2/mux.h                     |   10 ++
 arch/arm/mach-omap2/serial.c                  |  190 +++++++++----------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    9 +-
 drivers/tty/serial/omap-serial.c              |   83 +++++++++++-
 5 files changed, 165 insertions(+), 130 deletions(-)
