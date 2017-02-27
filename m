From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 14:54:08 -0600
Subject: [PATCH v4] reset: Add i.MX7 SRC reset driver
In-Reply-To: <20170221161331.17012-1-andrew.smirnov@gmail.com>
References: <20170221161331.17012-1-andrew.smirnov@gmail.com>
Message-ID: <20170227205408.ajeu3stjpl45dnqf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 08:13:31AM -0800, Andrey Smirnov wrote:
> Add reset controller driver exposing various reset faculties,
> implemented by System Reset Controller IP block.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Changes since v3 (see [v3]):
> 
> 	- Convert code IMX7_RESET_PCIEPHY to change G_RST and BTNRST
>           simultaneously to make all resets be representable as
>           signal->bit in signal->offset register
> 
> 	- Convert assert/deassert subroutines to be special cases of a
>           common reset subroutine
> 
> Changes since v2 (see [v2]):
> 
> 	- Fix typos
> 
> 	- Kconfig/Makefile chagnes account for alphabetical sorting of
>           those files
> 
> 	- Remove redundant includes
> 
> 	- Make use of regmap_attach_dev and avoid storing refernce to
>           struct *dev in private data
> 
> 	- Change code and headers to expose almost all of the reset
>           related bits in SRC IP block
> 
> Changes since v1 (see [v1]):
> 
> 	- Various small DT bindings description fixes as per feedback
>           from Rob Herring
> 
> 
> [v1] https://lkml.org/lkml/2017/2/6/554
> [v2] https://lkml.org/lkml/2017/2/13/488
> [v3] https://lkml.org/lkml/2017/2/20/344
> 
> 
>  .../devicetree/bindings/reset/fsl,imx7-src.txt     |  47 ++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/reset/Kconfig                              |   8 ++
>  drivers/reset/Makefile                             |   2 +
>  drivers/reset/reset-imx7.c                         | 158 +++++++++++++++++++++
>  include/dt-bindings/reset/imx7-reset.h             |  62 ++++++++
>  5 files changed, 277 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
>  create mode 100644 drivers/reset/reset-imx7.c
>  create mode 100644 include/dt-bindings/reset/imx7-reset.h
