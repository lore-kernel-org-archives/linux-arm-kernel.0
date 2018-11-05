From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2018 06:33:20 -0800
Subject: mainline/master boot bisection: v4.19-12838-g71e56028173b on
 beagle-xm
In-Reply-To: <a4d3b4ea-fcc5-f65b-70e2-bd12f089d0e6@collabora.com>
References: <5bdebe88.1c69fb81.3857a.05d1@mx.google.com>
 <a4d3b4ea-fcc5-f65b-70e2-bd12f089d0e6@collabora.com>
Message-ID: <CAOesGMgcuGKgNiN44jOS_9qRo3es8W6kt5-o676ouwpcAZC6KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2018 at 1:43 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Hi Linus,
>
> Please see below, the kernelci.org automated boot bisection found
> that the OMAP3 BeagleBoard-xM is failing to boot with SMP
> disabled and PREEMPT enabled in multi_v7_defconfig.  There is no
> log output after the bootloader so the kernel seems to be
> crashing very early on.

Can you enable DEBUG_LL to capture what goes wrong?

The regression is on me. Linus sent the patch, but I was trigger happy
and applied it to fixes instead of letting it soak in -next longer.

I'll revert it in our fixes branch and send it in quickly, and apply
it to a branch picked up by -next instead.


-Olof
