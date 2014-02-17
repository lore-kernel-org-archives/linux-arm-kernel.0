From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 12:13:09 +0900
Subject: [PATCH 0/5] enable i2c on koelsch-dt (and cleanup lager)
In-Reply-To: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
Message-ID: <CANqRtoRvB5zqEPFJBaC548+_S_+KXY5+acQ-zXFPG5DSxp2L7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Sun, Feb 16, 2014 at 6:40 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> This series adds all rcar cores to the r8a7791 dtsi and enables bus 2 on the
> koelsch board. Functionality was tested with reading/writing to an eeprom. Some
> rcar driver issues have been observed, but they are independent from the dt
> binding provided here. On the way, some cleanups were found which apply to
> r8a7790 as well, yet those are only compile tested since I don't have HW access
> to the lager board (yet).
>
> The series is based on tag 'renesas-devel-v3.14-rc2-20140213' and can be found here
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r8a7791-i2c
>
> Please review/apply.

Thanks for your patches. I think they look good in general, but patch
[2/5] needs to be reworked to exclude the r8a7790 compatible string.
Patch [3/5] probably depends on [2/5] so it needs to wait too.

> Wolfram Sang (5):
>   ARM: shmobile: r8a7791: remove superfluous interrupt-parents
[1/5] looks fine

>   ARM: shmobile: r8a7791: add i2c master nodes to dtsi
>   ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
[2/5] needs rework
[3/5] depends on [2/5] - needs to wait

>   ARM: shmobile: r8a7790: remove superfluous interrupt-parents
>   ARM: shmobile: r8a7790: add i2c aliases to dtsi
[4/5] looks good
[5/5] looks good

For the patches [1/5], [4/5], [5/5]

Acked-by: Magnus Damm <damm@opensource.se>

Let us discuss [2/5] in a separate thread.

Thanks for your help!

/ magnus
