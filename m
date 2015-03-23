From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 Mar 2015 02:37:05 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
 <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150320222320.GL8656@n2100.arm.linux.org.uk>
 <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdVLWffQW3d_4z9RAQOg8BCUCSU6ny3yG0poZ_7v=ozNbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Sat, Mar 21, 2015 at 4:39 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
>> However, SMP_ON_UP is incompatible with XIP_KERNEL (as already listed in its dependencies) and building with SMP=y without SMP_ON_UP, and trying to run on UP hardware will definitely fail.
>
> So, it sounds like you are saying XIP_KERNEL and SMP is not going to happen.

I think you misunderstood: XIP_KERNEL=y and SMP=y should work on an SMP
system, XIP_KERNEL=y and SMP=n should work on a uniprocessor system.

The problem is SMP_ON_UP (run SMP=y kernel on a uniprocessor system).
You just can't have one kernel that works on both.

As Arnd mentioned, making XIP_KERNEL depend on !SMP_ON_UP sounds
like the way to go.

BTW, since you're asking about SMP=y, I guess you're not just interested in
running XIP_KERNEL=y on r7s72100, which is UP?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
