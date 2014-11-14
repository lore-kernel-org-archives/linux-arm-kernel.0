From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 17:23:41 +0100
Subject: [PATCH v4 0/2] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <1415980187-12683-1-git-send-email-geert+renesas@glider.be>
References: <1415980187-12683-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1602253.050FQygs2a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 16:49:45 Geert Uytterhoeven wrote:
>         Hi Simon, Magnus, Arnd,
> 
> This patch series adds serial port debug macros for the SCIF(A) serial ports.
> This includes all supported shmobile SoCs, except for EMEV2.
> 
> It contains 2 patches, which are two alternative versions:
>   - The first patch keeps on using the identity mapping set up by .map_io()
>     on platforms I cannot test myself (sh7372 and r8a7779),
>   - The second one converts the remaining platforms to use debug_ll_io_init(),
>     which allowed to get rid of the #ifdef in renesas-scif.S, and consolidate
>     more config options.
> 
> Both versions work fine on r8a7791/koelsch (multiplatform), r8a7740/armadillo
> (legacy and reference), and sh73a0/kzm9g (legacy, reference, and
> multiplatform), also with a multiplatform kernel based on shmobile_defconfig.
> 
> I'd appreciate if you could test the second one on sh7372 and r8a7779,
> and if it works, apply it.
> 
> Else, please apply the first version. We can do incremental conversions later,
> as discussed before.

Both versions look good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I do notice that strictly speaking you break alphabetical ordering by putting
DEBUG_R8A* and DEBUG_RCAR* after DEBUG_RK*, but it does seem way more reasonable
like this.

	Arnd
