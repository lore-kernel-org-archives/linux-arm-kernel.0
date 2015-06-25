From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Jun 2015 16:02:55 +0100
Subject: [PATCH v2 7/9] ARM: multi_v7_defconfig: Enable support for PWM
 Regulators
In-Reply-To: <CABxcv==_YZ7BCCzfbLXYxwUL_kKLtBxOVTCvcUnvGVnrD4bVpg@mail.gmail.com>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
 <1435154348-28840-8-git-send-email-lee.jones@linaro.org>
 <CABxcv==J2hi0y+=s3nK_U=-jkjTW3L9jCC2JfebnWwRfpDGLAQ@mail.gmail.com>
 <20150625084204.GW15013@x1>
 <CABxcv==_YZ7BCCzfbLXYxwUL_kKLtBxOVTCvcUnvGVnrD4bVpg@mail.gmail.com>
Message-ID: <20150625150255.GE23990@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Jun 2015, Javier Martinez Canillas wrote:
> On Thu, Jun 25, 2015 at 10:42 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 24 Jun 2015, Javier Martinez Canillas wrote:
> 
> [...]
> 
> >> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> >> > index f632af0..6666973 100644
> >> > --- a/arch/arm/configs/multi_v7_defconfig
> >> > +++ b/arch/arm/configs/multi_v7_defconfig
> >> > @@ -365,6 +365,7 @@ CONFIG_REGULATOR_MAX8907=y
> >> >  CONFIG_REGULATOR_MAX8973=y
> >> >  CONFIG_REGULATOR_MAX77686=y
> >> >  CONFIG_REGULATOR_PALMAS=y
> >> > +CONFIG_REGULATOR_PWM=y
> >>
> >> The current policy is to build as much as possible as a module in
> >> multi_v7_defconfig. Since this is a tristate Kconfig symbol, could you
> >> please change it to =m ?
> >
> > I would prefer that it stays built-in.
> >
> 
> Ok, I've no strong opinion on this. I was just mentioning what arm-soc
> maintainers prefer nowadays.
> 
> May I ask what's the rationale for leaving this option built-in?

My view is that multi_v7 is used for prototyping, testing and to
ensure all of the vendors are playing nice together.  Hopefully
vendors aren't actually releasing kernels built with this defconfig!
During testing/prototyping time; installing and messing around with
modules is an over-head I can do without.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
