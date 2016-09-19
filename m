From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 19 Sep 2016 11:21:21 +0200
Subject: [PATCH 0/1] fix rk3066a based boards boot issue on linux-4.8
In-Reply-To: <1474274639-27768-1-git-send-email-andy.yan@rock-chips.com>
References: <1474274639-27768-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20160919112121.2e0bc376@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Mon, 19 Sep 2016 16:43:59 +0800
Andy Yan <andy.yan@rock-chips.com> wrote:

> Hi, heiko:
>    I found my Rayeager board couldn't boot up on linux 4.8. After some
> dig, I found the pwm-regulator for vdd_log register failed and found
> some change in Boris's patch: commit 87248991a1de(regulator: pwm: Properly
> initialize the ->state field).

Hm, that's weird. This commit only makes sure that the regulator
voltage state is correctly initialized (matching the hardware state),
and I don't understand why changing the voltage-table make it work.

Can you share the kernel logs? What are the symptoms?

Thanks,

Boris

>    I send this patch to make the pwm-regulator can register success on
> this change.
> 
> 
> Andy Yan (1):
>   arm: dts: fix rk3066a based boards vdd_log voltage initialization
> 
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts  | 2 +-
>  arch/arm/boot/dts/rk3066a-marsboard.dts | 2 +-
>  arch/arm/boot/dts/rk3066a-rayeager.dts  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
