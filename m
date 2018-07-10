From: cphealy@gmail.com (Chris Healy)
Date: Tue, 10 Jul 2018 08:47:28 -0700
Subject: [PATCH] ARM: dts: imx: Add ZII SCU2 Mezz board
In-Reply-To: <20180707024902.439-1-andrew.smirnov@gmail.com>
References: <20180707024902.439-1-andrew.smirnov@gmail.com>
Message-ID: <CAFXsbZqgc7B-YE-aFgT=Qz20u+JRvvfdQFgh77Zv-+w62GA7XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Successfully tested on an SCU2 Mezz board.

Tested-by: Chris Healy <cphealy@gmail.com>

On Fri, Jul 6, 2018 at 7:49 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Add support for the Zodiac Inflight Innovations SCU2 Mezz
> board (i.MX51-based).
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: cphealy at gmail.com
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Shawn:
>
> This is a spin-off of SCU2 Mezz board support originally found in [v0]
> as per out off-list (Fabio, Chris, Nikita, myself) to add support for
> ZII hardware fist and worry about factoring out commonalites later.
>
> Original submission was done by Andrey Gusakov, but he is too busy on
> other projects, so the honors of submitting this were delegated to me.
>
> NOTE: RAVE SP ("zii,rave-sp-mezz") node is technically supported by
> upstream, but it needs some fixes from [rave-sp-fixes] to work
> correctly. If you want me to drop that node until [rave-sp-fixes] is
> merged, let me know.
>
> Changes since [v0]:
>
>  - Patch converted to be a standalone file not dependent on any
>    ZII-specific .dtsi
>
>  - Added RAVE SP node with all the children that are currently
>    supported by upstream
>
>  - Droppped ecspi2 node. That node didn't have any child devices in
>    [v0] because none of the chips connected to that bus are supported
>    upstream. This node can be added later once anything attached to it
>    has upstream drivers.
>
>  - Dropped i2c_gpio. That bus was originally added for RAVE SP related
>    prototyping and is unused in actual product.
>
>  - Various newline fixes pointed out in [v0]
>
>  - Most of then nodes should be sorted alphabetically (I might have
>    missed some)
>
>  - Collected Reviewed-by from Fabio (Fabio, I assumed you won't mind,
>    but let me know if you want me to drop it)
>
> [v0] lkml.kernel.org/r/1529603100-31958-4-git-send-email-andrey.gusakov at cogentembedded.com
> [rave-sp-fixes] lkml.kernel.org/r/20180707024108.32373-1-andrew.smirnov at gmail.com
>
>  arch/arm/boot/dts/Makefile                |   3 +-
>  arch/arm/boot/dts/imx51-zii-scu2-mezz.dts | 448 ++++++++++++++++++++++
>  2 files changed, 450 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
