From: henryc.chen@mediatek.com (Henry Chen)
Date: Fri, 19 Feb 2016 13:08:02 +0800
Subject: [RFC PATCH 4/5] PM / AVS: thermal: MT8173: Introduce support
 for SVS engine
In-Reply-To: <20160218030049.GA8780@gmail.com>
References: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
 <1453452029-20843-5-git-send-email-pi-cheng.chen@linaro.org>
 <CAGS+omAYPhJ80kHG=bW4AjFsQzhwUfC6C+nAXa=Ny5UyoCid=w@mail.gmail.com>
 <20160218030049.GA8780@gmail.com>
Message-ID: <1455858482.17104.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2016-02-18 at 11:00 +0800, Pi-Cheng Chen wrote:

> > > +               vboot = regulator_get_voltage(svs->reg) / 1000;
> > > +               if (mvolt_to_config(vboot) !=
> > > +                   mvolt_to_config(svs_bank_cfgs[i].vboot)) {
> > > +                       dev_err(svs->dev, "Vboot value mismatch!\n");
> > > +                       ret = -EINVAL;
> > > +                       break;
> > > +               }
> > > +
> > > +               ret = regulator_set_mode(svs->reg, REGULATOR_MODE_FAST);
> > > +               if (ret) {
> > > +                       dev_err(svs->dev,
> > > +                               "Failed to set regulator in PWM mode\n");
> > > +                       ret = -EINVAL;
> > > +                       break;
> > > +               }
> > 
> > Shouldn't this be best effort?
> > If we can't set the regulator to fast mode, can we continue anyway?
> > 
> 
> AFAIK, we need to set the regulator to fast mode to get stable voltage as
> possible. I am sure about the details.
> 
> @Henry,
> Would you please comment it?

Hi,

Yes, as you said, PTPOD need the more precisely voltage as possible when
driver initialize, there has two mode in mt6397: pwm/auto mode, the pwm
mode which can get the more stable Vout than auto mode.

Thanks,
Henry
