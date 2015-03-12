From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 12 Mar 2015 09:21:56 +0100
Subject: [PATCH 0/2] ARM: shmobile: Correct SYSCIER values
In-Reply-To: <20150312081442.GA4295@verge.net.au>
References: <1426132537-31606-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUuv6YrEUsCpbuZwHUy_a-+sK8O=q8k-OZLZRytKv7gyA@mail.gmail.com>
 <20150312081442.GA4295@verge.net.au>
Message-ID: <CAMuHMdUh=FE4_ZrKKg03aEKCWNhWWdNVHN361v39aA2JZKyFHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Mar 12, 2015 at 9:14 AM, Simon Horman <horms@verge.net.au> wrote:
> FWIW the values in these patches are the ones that
> you supplied in another email thread. However, I did
> verify them against (my reading of) the documentation.

We could introduce symbols for them. I don't think it's worth doing that at
this point, as ideally these values should come from DT.

If you disagree, feel free to use what I was carrying in my local tree
to get a better understanding (needs some consolidation):

/* SYSC Interrupt Status/Status Clear/Enable/Mask Register */
/* R-Car H1 */
#define SYSCI_IMP               BIT(24) /* IMP-X3 */
#define SYSCI_VDP               BIT(21) /* VDP1 */
#define SYSCI_SGX               BIT(20) /* SGX543 MP2 */
#define SYSCI_SH4A              BIT(16) /* SH-4A (Not documented on H1) */
#define SYSCI_ARM3              BIT(3)  /* ARM3 */
#define SYSCI_ARM2              BIT(2)  /* ARM2 */
#define SYSCI_ARM1              BIT(1)  /* ARM1 */

/* R-Car H2 */
#define SYSCI_IMP               BIT(24) /* IMP-X4 */
#define SYSCI_CA7_SCU           BIT(21) /* CA7-SCU */
#define SYSCI_RGX               BIT(20) /* RGX */
#define SYSCI_SH4A              BIT(16) /* SH-4A */
#define SYSCI_CA15_SCU          BIT(12) /* CA15-SCU */
#define SYSCI_CA7_CPU(i)        BIT(5 + (i))    /* CA7-CPUi */
#define SYSCI_CA15_CPU(i)       BIT(i)  /* CA15-CPUi */

/* R-Car M2-W/M2-N */
#define SYSCI_SGX               BIT(20) /* SGX */
#define SYSCI_SH4A              BIT(16) /* SH-4A */
#define SYSCI_CA15_SCU          BIT(12) /* CA15-SCU */
#define SYSCI_CA15_CPU(i)       BIT(i)  /* CA15-CPUi */

/* R-Car V2H */
#define SYSCI_IMP               BIT(24) /* IMP-X4 */
#define SYSCI_SGX               BIT(20) /* SGX */
#define SYSCI_CA15_SCU          BIT(12) /* CA15-SCU */
#define SYSCI_CA15_CPU(i)       BIT(i)  /* CA15-CPUi */

/* R-Car E2 */
#define SYSCI_CA7_SCU           BIT(21) /* CA7-SCU */
#define SYSCI_SGX               BIT(20) /* SGX */
#define SYSCI_SH4A              BIT(16) /* SH-4A */
#define SYSCI_CA7_CPU(i)        BIT(5 + (i))    /* CA7-CPUi */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
