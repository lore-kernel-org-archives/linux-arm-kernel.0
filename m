From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 16 Feb 2015 10:03:54 +0100
Subject: [PATCH v3] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <1423874574-3494-1-git-send-email-sboyd@codeaurora.org>
References: <1423874574-3494-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAMuHMdWcuWacOxrTAYB3CBJHTN6SJfmVZTTT4oxHJwj+qTLGOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 14, 2015 at 1:42 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -104,6 +104,7 @@ struct smp_operations {
>  #ifdef CONFIG_HOTPLUG_CPU
>         int  (*cpu_kill)(unsigned int cpu);
>         void (*cpu_die)(unsigned int cpu);
> +       int  (*cpu_can_disable)(unsigned int cpu);

Perhaps this should be changed to return bool while you're adding the function?
That saves us from an atomic update later when someone does janitorial work.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
