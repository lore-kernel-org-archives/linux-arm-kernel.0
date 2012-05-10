From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Thu, 10 May 2012 12:08:10 +0530
Subject: [PATCH 0/8] gpio/omap: remaining cleanups and fix
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <CAMrsUdJg6bftZdtGM3Pfz7FO=69AfgCc86cDgGRxHW2gXR+0BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarun,

On Fri, Apr 27, 2012 at 7:43 PM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> Here are the remaining cleanup patches. There are broadly
> two categories of cleanups.
>
> Cat-1: Those missed while introducing new feature like SPARSE_IRQ
> ? ? ? handling and DT support; use edge/level handlers from
> ? ? ? generic IRQ framework.
>
> Cat-2: Removal of redundant fields from struct gpio_bank{} as a
> ? ? ? result of they being already covered by members within
> ? ? ? context field of struct gpio_bank{}.
>
> Reference: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Commit: 66f75a5d028beaf67c931435fdc3e7823125730c (Linux 3.4-rc4)
>
> Series is available for reference here:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev.git for_3.5/gpio_more_cleanup_fixes


I tested this series from your tree on Beagle-XM retention, offmode,
suspend to mem and resume with and and without enabling offmode
from sysfs was checked and found retention count and off mode
count was getting incremented.

Also ran few test cases available from here[1] to request and release gpio,
test cases passed.

Feel Free to add:

Tested-by: Govindraj.R <govindraj.raja@ti.com>

--
Thanks
Govindraj.R

[1]: http://gitorious.org/omap-ddt/omap-ddt/trees/master/gpio/test_code/utils/gpio_mods
