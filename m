From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 4 May 2015 09:48:43 +0200
Subject: [PATCH 0/7] Add SMP bringup support for mt65xx socs
In-Reply-To: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CABuKBeJ406DUFoVs2p3-u6sW58Dm7XDd6uxCc==Mkq3dMhhd5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yingjoe,

2015-05-01 9:43 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> This series add SMP brinup support for mediatek SoCs. This is based
> on v4.1-rc1.
>
> There are 2 similar but different SMP bringup up methods on Mediatek
> mt65xx and mt81xx. On MT8135 & MT8127, system boots with a trustzone
> firmware. Others, like MT6589, doesn't have trustzone, and run kernel
> directly in secure world.
>
> Patch 1~3 fix issues in mtk_timer(GPT) and enable arch timer support.
> Patch 4,5 add support for cpu enable-method "mediatek,mt65xx-smp" and
> "mediatek,mt81xx-tz-smp", which support Mediatek SMP bringup for non-TZ
> and TZ platform.
> Patch 6,7 finally enable SMP bringup for mt8135 and mt8127.
>
> Matthias Brugger (1):
>   arm: mediatek: enable gpt6 on boot up to make arch timer working
>
> Yingjoe Chen (6):
>   clocksource: mediatek: Don't run event_handler if it is NULL
>   clocksource: mediatek: Use GPT as sched clock source
>   devicetree: bindings: add new SMP enable method Mediatek SoC
>   ARM: mediatek: add smp bringup code
>   ARM: dts: mt8135: enable basic SMP bringup for mt8135
>   ARM: dts: mt8127: enable basic SMP bringup for mt8127
>

I tried on the mt8135 eval board but it fails to bring up the CPU.

When booting:
[    1.048588] CPU1: failed to come online
[    2.049914] CPU2: failed to come online
[    3.051245] CPU3: failed to come online

And from userspace:
/ # echo 1 > /sys/devices/system/cpu/cpu1/online
[   40.115142] CPU1: failed to come online
sh: write error: Input/output error
/ # echo 1 > /sys/devices/system/cpu/cpu2/online
[   44.667141] CPU2: failed to come online
sh: write error: Input/output error
/ # echo 1 > /sys/devices/system/cpu/cpu3/online
[   51.271141] CPU3: failed to come online
sh: write error: Input/output error

Please check again.

Cheers,
Matthias
