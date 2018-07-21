From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 21 Jul 2018 20:58:32 +0200
Subject: [PATCH 0/3] Meson8/Meson8b: add the ARM TWD timer
In-Reply-To: <20180721173721.31361-1-martin.blumenstingl@googlemail.com>
References: <20180721173721.31361-1-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCBRp1V6DSNNj6pB7OqeD5WFAYAhR6Sbw5kcLi4k2y9TOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 7:37 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Carlo sent a .dts patch for the ARM TWD (timer watchdog) a long time
> ago: [0]
> This patch was never applied. While resurrecting it I found out (by
> trial and error) that the TWD clock is derived from the CPU clock by
> dividing the existing CPU clock by 16. Additionally I found out that
> the interrupt is defined incorrectly, leading to an error message
> during boot: "GIC: PPI13 is secure or misconfigured".
>
> Amlogic's GPL kernel does not use the TWD timer. However, it seems to
> work fine for me and it fixes the following warnings during boot:
>   Clockevents: could not switch to one-shot mode:
>   Clockevents: could not switch to one-shot mode:
>   Clockevents: could not switch to one-shot mode:
>   Clockevents: could not switch to one-shot mode:
>    dummy_timer is not functional.
>    dummy_timer is not functional.
>    dummy_timer is not functional.
>    dummy_timer is not functional.
>   Could not switch to high resolution mode on CPU 0
>   Could not switch to high resolution mode on CPU 2
>   Could not switch to high resolution mode on CPU 3
>   Could not switch to high resolution mode on CPU 1
>
> I chose not to split the interrupt line at 80 chars to make it easier
> to read (in my opinion, other .dts are not splitting it either).
>
> NOTE: This series depends on the following clock driver changes: [1]
Kevin, please ignore this series

I just realized that it depends on a clock controller change I have in
my local tree which is not upstream yet
the TWD timer driver needs to load early in the boot process where the
clock controller driver is (currently) not loaded yet
I'll send patches for the clock controller driver and re-send this
afterwards - sorry for the noise


Regards
Martin
