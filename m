From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jan 2016 11:32:51 +0100
Subject: [PATCH 1/3] driver-core: platform: Add platform_irq_count()
In-Reply-To: <1452129169-2014-2-git-send-email-sboyd@codeaurora.org>
References: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
 <1452129169-2014-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <15028940.raimA3k85Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 January 2016 17:12:47 Stephen Boyd wrote:
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
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I think there are a couple of other drivers that can use this too.

	Arnd
