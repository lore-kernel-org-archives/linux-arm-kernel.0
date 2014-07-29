From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 29 Jul 2014 16:39:19 +0200
Subject: [PATCH v2 3/4] ARM: dts: exynos5250: Fold common ChromeOS parts
 into Snow
In-Reply-To: <53D79AD3.8020700@suse.de>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
 <1405704009-8430-4-git-send-email-afaerber@suse.de>
 <CABxcv=kP2PCcNCtM1WUXx5wGG4m-jdw-P1dw0boaSwdJpoX=jQ@mail.gmail.com>
 <CAD=FV=V-7+Jj7b8-fQL1PiQhNmhiGOPJzitGd__OUQLDteO_8g@mail.gmail.com>
 <CABxcv=nDsKSdDtVZKpcTP+=3pbeTswJRCUvvXVx98p+1Zzz0Bg@mail.gmail.com>
 <53D79AD3.8020700@suse.de>
Message-ID: <CABxcv=mALxA=dK0Ue_LC1Qz1HUsvf3C4h13q7FgDv+PEoKvRNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On Tue, Jul 29, 2014 at 3:00 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi Javier and Doug,
>
>
> Hm, in different context it was stated that device trees shouldn't rely
> on bootloader behavior (for a /memory node on Zynq we ended up
> specifying the size cell with the real value despite U-Boot overriding
> it to a lesser value).
>

Well is not strictly the same, the memory node is a hardware
description while the chosen node is one of those exceptional nodes
that don't represent a real device. Also the usage for the memory node
is marked as required in ePAR while the later is marked as optional.

> Can we instead settle on filling this node with defaults? :)
> bootargs = "console=tty1"; would be my choice for Spring. Would that be
> applicable for Snow as well?
> Not sure how to specify that via linux,stdout-path property.
>
> I believe this would be a follow-up patch either way.
>
> Since there's at least two series out there trying to fiddle with
> -cros-common.dtsi, including one that drops the slot sub-node of the MMC
> and one that adds CPU power supply, it would be nice if we can get the
> -cros-common parts sorted out and applied. Can you ack/review 1-2?
> Should I squash them in a v3?
>

A sensible default makes sense to me and yes it should be a follow-up
patch anyways.

> Thanks,
> Andreas
>
> --

Best regards,
Javier
