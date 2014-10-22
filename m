From: dianders@chromium.org (Doug Anderson)
Date: Wed, 22 Oct 2014 10:17:57 -0700
Subject: [PATCH v6 1/3] power-domain: add power domain drivers for
 Rockchip platform
In-Reply-To: <1413964424-7599-2-git-send-email-jinkun.hong@rock-chips.com>
References: <1413964424-7599-1-git-send-email-jinkun.hong@rock-chips.com>
 <1413964424-7599-2-git-send-email-jinkun.hong@rock-chips.com>
Message-ID: <CAD=FV=Urn8_F+g0G08MLG3TeJsycpoa5K8+rwGDeG=Pk7dFCqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jinkun,

On Wed, Oct 22, 2014 at 12:53 AM, jinkun.hong
<jinkun.hong@rock-chips.com> wrote:
> +#define to_rockchip_pd(_gpd) container_of(_gpd, struct rockchip_domain, base)
> +
> +static int rockchip_pmu_set_idle_request(struct rockchip_domain *pd,
> +                                        bool idle)
> +{
> +       u32 idle_mask = BIT(pd->idle_shift);
> +       u32 idle_target = idle << (pd->idle_shift);
> +       u32 ack_mask = BIT(pd->ack_shift);
> +       u32 ack_target = idle << (pd->ack_shift);
> +       unsigned int mask = BIT(pd->req_shift);
> +       unsigned int val;
> +       unsigned long flags;

warning: unused variable 'flags'


> +static int rockchip_pmu_set_power_domain(struct rockchip_domain *pd,
> +                                        bool on)
> +{
> +       unsigned long flags;

warning: unused variable 'flags'


I haven't done any review of these patches, but I'll say that I did
pick your patches (along with "PM / clock_ops: Add pm_clk_add_clk()"
from https://patchwork.kernel.org/patch/5105401/) and I was able to
boot up my system.  Also, your series plus a patch to set the GPU
power domain on rk3288 made suspend/resume work better.

-Doug
