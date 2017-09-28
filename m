From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 28 Sep 2017 08:21:26 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable USB3503 driver
In-Reply-To: <20170928024022.2071-1-linus.luessing@c0d3.blue>
References: <20170928024022.2071-1-linus.luessing@c0d3.blue>
Message-ID: <CAJKOXPfQ3nXHVYXUn0iDfzVQc+ML1sSCz3NG_bwUw=WDK0id_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 4:40 AM, Linus L?ssing <linus.luessing@c0d3.blue> wrote:
> The Odroid U3 (Exynos 4412 based) for instance needs this driver,
> otherwise its USB hub will not come up.
>
> exynos_defconfig already has this enabled as built-in, too. So
> just doing the same here in multi_v7_defconfig.
>
> Signed-off-by: Linus L?ssing <linus.luessing@c0d3.blue>
>
> ---
> Thanks to Tobias Jakobi, who indirectly made me aware of why USB
> did not work for me.
>
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Partially this was part of my patchset fixing powersequence for
usb3503 and lan9730:
https://patchwork.kernel.org/patch/9502939/
but that patch waits still for power sequence.

Anyway please define this as a module (unless it can't... but it
worked in my case).

Best regards,
Krzysztof
