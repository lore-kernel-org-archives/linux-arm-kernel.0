From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 13 Jul 2018 12:11:05 +0900
Subject: [PATCH/RFC] ARM: shmobile: Always enable ARCH_TIMER on SoCs with
 A7 and/or A15
In-Reply-To: <20180712160857.31471-1-geert+renesas@glider.be>
References: <20180712160857.31471-1-geert+renesas@glider.be>
Message-ID: <CANqRtoTuofutGtWycNcHq+rPzHqAsjy8ZY0W0k9m_SNWnOajVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 1:08 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> R-Mobile APE6, R-Car Gen2, and RZ/G1 SoCs have Cortex-A7 and/or
> Cortex-A15 CPU cores, all of which have ARM architectured timers.
>
> Force use of the ARM architectured timer on these SoCs.
> This allows to:
>   - Remove the calls to shmobile_init_delay() from the corresponding
>     machine vectors,
>   - Remove a check in timer setup specific to R-Car Gen2,
>   - Remove a check in shmobile_init_delay().
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Hi Geert,

Thanks for cleaning up stuff.

> We still need shmobile_init_delay to setup loops-per-jiffies for the
> other SoCs.  But perhaps we can use the Cortex-A9 global timer on those?

Perhaps unrelated, but on older kernels with Cortex-A9 the TWD timer
was only available when using SMP. So historically on our single-core
systems (with CA8 or CA9 or when using CA9 multi core with maxcpus=1)
we had no timer available unless we also used a CMT/TMU or similar.

Exactly what the level of software support is available for the ARM
timers at this point I'm not so sure about.

Cheers,

/ magnus
