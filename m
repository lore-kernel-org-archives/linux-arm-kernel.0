From: carlo@caione.org (Carlo Caione)
Date: Fri, 1 May 2015 10:00:04 +0200
Subject: [PATCH 1/3] clk: meson: Add support for Meson clock controller
In-Reply-To: <CAOQ7t2b4aD14xjXN96k977OXw+GbKCh3Nu3Yh-Qx7A7Cm0j_tg@mail.gmail.com>
References: <1425313322-18567-1-git-send-email-carlo@caione.org>
 <1425313322-18567-2-git-send-email-carlo@caione.org>
 <20150410233135.18916.85534@quantum>
 <CAOQ7t2b4aD14xjXN96k977OXw+GbKCh3Nu3Yh-Qx7A7Cm0j_tg@mail.gmail.com>
Message-ID: <CAOQ7t2YXBLrnfnAFYM0S0UfikRn1Ab+JVU__6YvM6GRCstA+YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 22, 2015 at 9:31 AM, Carlo Caione <carlo@caione.org> wrote:
> On Sat, Apr 11, 2015 at 1:31 AM, Michael Turquette
> <mturquette@linaro.org> wrote:
>> Why use a notifier for this? Could you simply call
>> meson_clk_cpu_{pre,post}_rate_change directly from
>> meson_clk_cpu_set_rate?
>
> Hi Mike,
>
> the notifier is used to reparent the CPU clock when the frequency of
> the parent PLL is changed and before the PLL frequency is actually
> changed.
> IIUC using the {pre,post} hooks from meson_clk_cpu_set_rate doesn't
> achieve the same. The idea is adapted from the CPU clock driver of the
> rockchip SoCs (rockchip/clk-cpu.c).

Hey Mike,
what do you think about this point?

-- 
Carlo Caione
