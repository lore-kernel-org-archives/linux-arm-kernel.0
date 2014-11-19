From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 19 Nov 2014 15:49:54 +0000
Subject: [PATCH] thermal: sti: Ignore suspend/resume functions when !PM
In-Reply-To: <CAOMZO5Dz-vz=zV1r3O_Pv0=WS+_Pk=kaBiK1hb2ttxy_BPwLnQ@mail.gmail.com>
References: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
 <CAOMZO5Dz-vz=zV1r3O_Pv0=WS+_Pk=kaBiK1hb2ttxy_BPwLnQ@mail.gmail.com>
Message-ID: <20141119154954.GB1875@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Nov 2014, Fabio Estevam wrote:

> On Wed, Nov 19, 2014 at 11:48 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > Prevents build warning:
> >
> > st_thermal.c:278:12:
> >     warning: ?st_thermal_suspend? defined but not used [-Wunused-function]
> > st_thermal.c:286:12:
> >     warning: ?st_thermal_resume? defined but not used [-Wunused-function]
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/thermal/st/st_thermal.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
> > index 90163b3..9841488 100644
> > --- a/drivers/thermal/st/st_thermal.c
> > +++ b/drivers/thermal/st/st_thermal.c
> > @@ -275,6 +275,7 @@ int st_thermal_unregister(struct platform_device *pdev)
> >  }
> >  EXPORT_SYMBOL_GPL(st_thermal_unregister);
> >
> > +#ifdef CONFIG_PM
> 
> Actually this should be #ifdef CONFIG_PM_SLEEP instead

You're right, someone already pointed this out, thanks.

I will re-submit in ~1min.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
