From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jul 2012 16:46:07 +0800
Subject: [PATCH 1/2] ARM: i.MX6: set ARCH_NR_GPIO to 244
In-Reply-To: <50162C7A.1060307@de.bosch.com>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
 <20120728133215.GG2128@S2101-09.ap.freescale.net>
 <5015624D.50305@googlemail.com>
 <20120730011426.GB30774@S2101-09.ap.freescale.net>
 <50162C7A.1060307@de.bosch.com>
Message-ID: <20120730084558.GE31509@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 08:40:58AM +0200, Dirk Behme wrote:
> - Do you like to propose a better macro than SOC_IMX6Q to cover
> imx3/imx6, too?
> 
No, I do not see the need of this.  CONFIG_ARCH_NR_GPIO is not the only
way to overwrite the default number.  We can define ARCH_NR_GPIOS to
the number we want in IMX platform headers.

> - Do imx3 and imx5 have the same GPIO number like imx6? I.e. 7 banks
> with 32 pins == 224 GPIOs?
> 
imx31, imx35: 3 banks
imx51: 4 banks
imx53: 7 banks

> >Looking at current users of this definition, you will find all of them
> >are defining a number bigger than 256 for extending the maximum number.
> >It might be a sign that having a gpio array which is a little bigger
> >than necessary is not a concern on machines today.
> 
> Or it might be a sign that they *have* more than 256? I don't know.

Yes.  I was actually saying that there is no platforms defining the
Kconfig symbol smaller than 256 to save the space.

> But what's the issue using a matching number if possible?
> 
At least for IMX, it does not help that much.

-- 
Regards,
Shawn
