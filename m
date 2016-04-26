From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 26 Apr 2016 09:30:45 +0200
Subject: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.7
In-Reply-To: <4737327.YB9LJZXs32@wuerfel>
References: <cover.1461558315.git.horms+renesas@verge.net.au>
 <4737327.YB9LJZXs32@wuerfel>
Message-ID: <CAMuHMdV_DN4YEzP1urC9LmKga6rkstGNDv20i96qnb=kS1+skw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Apr 25, 2016 at 11:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 25 April 2016 14:27:31 Simon Horman wrote:
>> Renesas ARM Based SoC DT Updates for v4.7
>>
>> * Configure NMI key as wakeup source in DT of kzm9g board
>> * Add SDHI support to DT of gose board
>> * Add support of UHS-I SDR-50 for SDHI to DT of r8a7790 SoC
>> * Correct interrupt type for ARM TWD in DT of r8a7779 and sh73a0 SoCs
>> * Add IIC support to DT of r8a7794 SoC
>> * Add CAN support to DT of r8a7793 and r8a7794 SoCs
>> * Add SCIF2 support to r8a7790 device tree
>> * Use CAN, JPU and USB3.0 fallback compatibility string
>>   in DT of r8a7791 and r8a7790 SoCs
>
> Pulled into next/dt, thanks!

Commit 93fafa81cad3da9c ("Merge branches 'next/dt' and 'next/dt64' into
for-next") accidentally re-added the line

        clock-output-names = "can_clk";

to arch/arm/boot/dts/r8a7791.dtsi, which was removed in commit
f617604fe5d74b9c ("ARM: dts: r8a7791: Remove unnecessary
clock-output-names properties") before.  It seems the same wrong
conflict resolution was made before in commit ef3b08c6c0d85753 ("Merge
branch 'fixes' into for-next").

While this won't cause failures, can you please remove the offending
line?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
