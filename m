From: robh@kernel.org (Rob Herring)
Date: Wed, 27 Jul 2016 10:12:33 -0500
Subject: [PATCH v2 1/4] iio: adc: rockchip_saradc: reset saradc
 controller before programming it
In-Reply-To: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
References: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
Message-ID: <20160727151233.GA31731@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 08:13:12PM +0800, Caesar Wang wrote:
> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-iio at vger.kernel.org
> Cc: linux-rockchip at lists.infradead.org
> 
> ---
> 
> Changes in v2:
> - Make the reset as an optional property, since it should work
> with old devicetrees as well.
> 
>  .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/adc/Kconfig                            |  1 +
>  drivers/iio/adc/rockchip_saradc.c                  | 31 ++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
