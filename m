From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 May 2014 20:14:52 +0800
Subject: [PATCH 0/5] pinctrl: sunxi: Add A31 external interrupts support
In-Reply-To: <1401272851-15873-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1401272851-15873-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66Pf7FX-vTzttAKD5kcZT23Zs70tB=fadMXYX64PHnnDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 28, 2014 at 6:27 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi everyone,
>
> This is an attempt at making the external interrupts on the A31 and
> the A23 working.
>
> The main difference with the previous code is that there's now several
> banks and several parent interrupts, instead of a single bank with a
> single parent interrupt in the older SoCs.
>
> Most of the diffstat is to register the new irq pin functions. The
> real code additions are those in the core pinctrl driver.
>
> Maxime
>
> Maxime Ripard (5):
>   pinctrl: sunxi: Remove irq_mask_ack and use irq_ack instead
>   pinctrl: sunxi: Add macro definition for pinctrl with more than one
>     interrupt
>   pinctrl: sunxi: Declare the number of interrupt banks in the
>     descriptor
>   pinctrl: sunxi: Declare the interrupt function for the A31
>   pinctrl: sunxi: Implement multiple interrupt banks support

The first 4 patches look good. The last one needs some work with the
sunxi_irq_*_reg helpers.


Thanks
ChenYu

>  drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c   |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c  |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c   |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c   | 217 +++++++++++++++++++---------
>  drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c   |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c       |  77 ++++++----
>  drivers/pinctrl/sunxi/pinctrl-sunxi.h       |  21 ++-
>  8 files changed, 219 insertions(+), 101 deletions(-)
>
> --
> 1.9.3
>
