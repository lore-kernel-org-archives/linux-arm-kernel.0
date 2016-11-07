From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 7 Nov 2016 19:41:58 +0200
Subject: [PATCH 3/6] clk: Add driver for Maxim-8997 PMIC clocks
In-Reply-To: <1478513376-14307-4-git-send-email-pankaj.dubey@samsung.com>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
 <1478513376-14307-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20161107174158.GB4865@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 03:39:33PM +0530, Pankaj Dubey wrote:
> The MAX8997 PMIC has 32.786kHz crystal oscillator which provides an
> accurate low frequency clock for MAX8997 internal circuit as well as
> external circuit. This patch adds support for these two clocks.
> 
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: devicetree at vger.kernel.org
> CC: linux-clk at vger.kernel.org
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/clk/Kconfig                       | 10 ++++
>  drivers/clk/Makefile                      |  1 +
>  drivers/clk/clk-max8997.c                 | 76 +++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/maxim,max8997.h | 23 ++++++++++

You need to split the dt-bindings header into separate one so others
could pull it.  Please also mention the dependencies between patches in
cover letter, because it does not look like it could be applied as is.

Best regards,
Krzysztof
