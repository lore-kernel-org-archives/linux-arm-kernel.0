From: dianders@chromium.org (Doug Anderson)
Date: Wed, 15 Oct 2014 20:44:40 -0700
Subject: [PATCH 1/4] ARM: rockchip: add suspend and resume for RK3288
In-Reply-To: <1413406066-16257-1-git-send-email-zyw@rock-chips.com>
References: <1413405987-16196-1-git-send-email-zyw@rock-chips.com>
 <1413406066-16257-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=Ve4=BuqqrboJ5uyz6+RAxAEvAe+G2myf+BCk8q2+3LGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Wed, Oct 15, 2014 at 1:47 PM,  <zyw@rock-chips.com> wrote:
> +static const struct platform_suspend_ops rk3288_suspend_ops = {
> +       .enter = rk3288_suspend_enter,
> +       .valid = suspend_valid_only_mem,
> +};

As per offline discussion, let's add the regulator calls in prepare / finish.
