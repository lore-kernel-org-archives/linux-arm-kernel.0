From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 6 Jan 2016 17:47:58 -0800
Subject: [PATCH 1/3] driver-core: platform: Add platform_irq_count()
In-Reply-To: <1452129169-2014-2-git-send-email-sboyd@codeaurora.org>
References: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
 <1452129169-2014-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160107014758.GB17796@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2016 at 05:12:47PM -0800, Stephen Boyd wrote:
> A recent patch added calls to of_irq_count() in the qcom pinctrl
> drivers and that caused module build failures because
> of_irq_count() is not an exported symbol. We shouldn't export
> of_irq_count() to modules because it's an internal OF API that
> shouldn't be used by drivers. Platform drivers should use
> platform device APIs instead. Therefore, add a platform_irq_count()
> API that mirrors the of_irq_count() API so that platform drivers
> can stay DT agnostic.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Gross <andy.gross@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/base/platform.c         | 20 ++++++++++++++++++++
>  include/linux/platform_device.h |  1 +
>  2 files changed, 21 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org
