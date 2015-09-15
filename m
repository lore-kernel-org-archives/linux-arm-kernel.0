From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 15 Sep 2015 15:12:30 +0100
Subject: [PATCH] ARM: Remove __ref on hotplug cpu die path
In-Reply-To: <1442276597-14325-1-git-send-email-sboyd@codeaurora.org>
References: <1442276597-14325-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <55F8274E.5060008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/09/15 01:23, Stephen Boyd wrote:
> Now that __cpuinit has been removed, the __ref markings on these
> functions are useless. Remove them. This also reduces the size of
> the multi_v7_defconfig image:
>
> $ size before after
>     text    data     bss     dec     hex filename
>     12683578        1470996  348904 14503478         dd4e36 before
>     12683274        1470996  348904 14503174         dd4d06 after
>
> presumably because now we don't have to jump to code in the
> .ref.text section and/or the noinline marking is removed.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <linux-omap@vger.kernel.org>
> Cc: <linux-arm-msm@vger.kernel.org>
> Cc: <spear-devel@list.st.com>
> Cc: <linux-tegra@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>
> This patch can be broken up into per-SoC if desired.
>

[...]

>   arch/arm/mach-vexpress/hotplug.c     | 2 +-

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
