From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 18 Jan 2013 10:54:23 +0000
Subject: [PATCH] ARM: remove unnecessary 'select GENERIC_GPIO'
In-Reply-To: <CACRpkdYw6V_GGjBsj_bzzkmFVTamuMq2oMwYDKhjMrXeS5j+fQ@mail.gmail.com>
References: <1358255616-3171-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdYw6V_GGjBsj_bzzkmFVTamuMq2oMwYDKhjMrXeS5j+fQ@mail.gmail.com>
Message-ID: <20130118105423.81C693E0962@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Jan 2013 14:36:00 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jan 15, 2013 at 2:13 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > The only use of GENERIC_GPIO (defined by architecture) in GPIO subsystem
> > is being selected by GPIOLIB.  Also there are no any use of the option
> > at architecture level. Only two sub-architectures shmobile and orion
> > really use the option as below.
> >
> >   arch/arm/mach-shmobile/Makefile:obj-$(CONFIG_GENERIC_GPIO)      += $(pfc-y)
> >   arch/arm/plat-orion/Makefile:orion-gpio-$(CONFIG_GENERIC_GPIO) += gpio.o
> >
> > Remove all those unnecessary sub-architecture level selection of
> > GENERIC_GPIO, which are there only for confusing people.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Looks good to me also.

Acked-by: Grant Likely <grant.likely@secretlab.ca>
