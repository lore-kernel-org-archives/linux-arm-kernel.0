From: dianders@chromium.org (Doug Anderson)
Date: Thu, 31 Mar 2016 08:57:31 -0700
Subject: [v14, 01/17] drm: bridge: analogix/dp: split exynos dp driver to
 bridge directory
In-Reply-To: <20160330203204.GA24156@roeck-us.net>
References: <1455534576-1486-1-git-send-email-ykk@rock-chips.com>
 <20160330203204.GA24156@roeck-us.net>
Message-ID: <CAD=FV=XkEb20_Ast80_7cVynifKxCWY18FFRN5mgD0Qq6FcXzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 30, 2016 at 1:32 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> This results in the following build errors if DRM_ANALOGIX_DP
> is configured as module.
>
> ERROR: "analogix_dp_start_video" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane0_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane1_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane2_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane3_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane_count" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_link_bandwidth" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
>
> [ and so on ]
>
> It should probably be something like
>
> analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o
> obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o

Sounds like this is a major problem.  Presumably Yakir should fix and
send a new pull request?

-Doug
