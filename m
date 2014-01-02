From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Jan 2014 12:21:08 -0800
Subject: DT include files (was: [GIT PULL 2/2] ARM: imx: device tree changes
 for 3.14)
In-Reply-To: <20131231054427.GA22383@S2101-09.ap.freescale.net>
References: <20131231054427.GA22383@S2101-09.ap.freescale.net>
Message-ID: <20140102202108.GF19720@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 31, 2013 at 01:44:29PM +0800, Shawn Guo wrote:
> This pull-request has the following two dependencies:
> 
>  - The first pull-request, i.e. [GIT PULL 1/2] ARM: imx: soc changes for 3.14
> 
>  - The pinctrl 'devel' branch below.
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
> 
>    Linus Walleij promised that the branch will be stable at least from
>    the point I pulled into my tree, that is commit 31d610f (pinctrl:
>    imx1-core populate subdevices).
> 
> Please pull, thanks.
> 
> Shawn
> 
>  .../devicetree/bindings/vendor-prefixes.txt        |    3 +
>  arch/arm/boot/dts/imx25-pinfunc.h                  |  494 +++++++++++
>  arch/arm/boot/dts/imx25-pingrp.h                   |   81 ++
>  arch/arm/boot/dts/imx27-pinfunc.h                  |  526 +++++++++++
>  arch/arm/boot/dts/imx27-pingrp.h                   |  151 ++++
>  arch/arm/boot/dts/imx35-pingrp.h                   |  104 +++
>  arch/arm/boot/dts/imx50-pinfunc.h                  |  923 ++++++++++++++++++++
>  arch/arm/boot/dts/imx50-pingrp.h                   |  146 ++++
>  arch/arm/boot/dts/imx51-pingrp.h                   |  249 ++++++
>  arch/arm/boot/dts/imx53-pingrp.h                   |  352 ++++++++
>  arch/arm/boot/dts/imx6dl-pinfunc.h                 |    2 +
>  arch/arm/boot/dts/imx6q-pinfunc.h                  |    2 +
>  arch/arm/boot/dts/imx6qdl-pingrp.h                 |  532 +++++++++++
>  arch/arm/boot/dts/imx6sl-pingrp.h                  |  148 ++++
>  arch/arm/boot/dts/vf610-pingrp.h                   |  127 +++

Hm, these don't quite use include files the way include files were
originally meant to be used -- initially the idea was to use them to
define mostly simple constants instead of full properties like this.

I'm not against the idea of using it this way, but I also want to make sure the
DT maintainers are OK with it. So I've cc:d them on this reply.

I'm also not crazy about the insanely long identifiers used here, but I guess
they correlate with some user manual tables?


-Olof
