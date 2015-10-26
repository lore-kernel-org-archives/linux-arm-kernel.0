From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Oct 2015 10:56:03 +0100
Subject: Possible Regression due to c074fef5d36e ("of/platform: Defer
 probes of registered devices").
In-Reply-To: <20151026094027.GA25225@gradator.net>
References: <20151026032039.GA1950@verge.net.au>
 <20151026094027.GA25225@gradator.net>
Message-ID: <CAMuHMdWmw8TqyOOMSPkh_1V+9OJeqPts1t3528ZQrJjzE6tmRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 10:40 AM, Sylvain Rochet
<sylvain.rochet@finsecur.com> wrote:
> On Mon, Oct 26, 2015 at 12:20:39PM +0900, Simon Horman wrote:
>> I have observed a possible regression in next-20151022
>> due to c074fef5d36e ("of/platform: Defer probes of registered devices").
>>
>> The problem manifests on the r8a7791 based koelsch board.
>> With the above patch present booting the board using the shmobile_defconfig
>> results in no console output. While after reverting the above patch
>> the boot proceeds all the way to user-space.
>>
>> With DEBUG_LL and EARLY_PRINTK enabled I was able to capture some console
>> output. I have included both that boot log, and a log of boot all the way to
>> userspace with the patch in question reverted.
>>
>> The problem does not seem to manifiest on other boards for other
>> Renesas ARM  SoCs that I have access too. In particular the
>> r8a7790 based lager board; the r8a7790 and r8a7791 are both members
>> of the R-Car Gen2 family of SoCs.
>
> Atmel SoC hit this regresssion too, discussion about this issue is in
> the following thread:
>  https://lkml.org/lkml/2015/10/16/733

More reading material in "[GIT PULL] On-demand device probing"
(https://lkml.org/lkml/2015/10/14/126)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
