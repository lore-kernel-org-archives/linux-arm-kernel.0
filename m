From: robh@kernel.org (Rob Herring)
Date: Thu, 6 Jul 2017 12:17:57 -0500
Subject: [PATCH 4/5] pwm: rockchip: Add atomic updated feature for rk3328
In-Reply-To: <1498739271-27431-5-git-send-email-david.wu@rock-chips.com>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
 <1498739271-27431-5-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170706171757.qmnvmdyjuj77tt27@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 08:27:50PM +0800, David Wu wrote:
> The rk3328 soc supports atomic update, we could lock the configuration
> of period and duty at first, after unlock is configured, the period and
> duty are effective at the same time.
> 
> If the polarity, period and duty need to be configured together,
> the way for atomic update is "configure lock and old polarity" ->
> "configure period and duty" -> "configure unlock and new polarity".
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       |  1 +

The subject is a bit misleading as you are adding support for a new 
version of the IP. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pwm/pwm-rockchip.c                         | 50 +++++++++++++++++++---
>  2 files changed, 46 insertions(+), 5 deletions(-)
