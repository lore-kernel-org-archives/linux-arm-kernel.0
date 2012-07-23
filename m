From: avinashphilip@ti.com (Philip, Avinash)
Date: Mon, 23 Jul 2012 09:16:46 +0000
Subject: [PATCH 2/2] PWM: EHRPWM: PWM driver support for EHRPWM.
In-Reply-To: <20120723074221.GB23797@avionic-0098.mockup.avionic-design.de>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-3-git-send-email-avinashphilip@ti.com>
 <20120723074221.GB23797@avionic-0098.mockup.avionic-design.de>
Message-ID: <518397C60809E147AF5323E0420B992E3E97157F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 13:12:21, Thierry Reding wrote:
> On Fri, Jul 13, 2012 at 03:05:02PM +0530, Philip, Avinash wrote:
> > Enhanced high resolution PWM module (EHRPWM) hardware can be used to
> > generate PWM output over 2 channels. This commit adds PWM driver support
> > for EHRPWM device present on AM33XX SOC. Current implementation supports
> > simple PWM functionality.
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> > Reviewed-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> So this driver is very similar to the ECAP one and pretty much all the
> comments apply to this as well. Some additional comments below.

Ok I will correct it for all the comments.

> 
> > ---
[snip]
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-ehrpwm.
> > +
> 
> Maybe it would be useful to prefix the names with AM33XX here. ECAP and
> EHRPWM are sort of generic and may have name clashes in the future.

Ok, I will make us TI prefix as davinci platform also uses same modules.

> 
> > +#define PWM_CHANNEL		2	/* EHRPWM channels */
> 
> I'd say you can just replace the one occurrence of this with the literal
> 2. If you still want to have the symbolic name, then I'd suggest to call
> it something like NUM_PWM_CHANNELS to make its meaning more obvious.

I will correct it as NUM_PWM_CHANNELS.

> 
> > +static int __devexit ehrpwm_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct ehrpwm_pwm_chip *pc = platform_get_drvdata(pdev);
> > +
> > +	if (WARN_ON(!pc))
> > +		return -ENODEV;
> > +
> > +	pm_runtime_disable(&pdev->dev);
> > +	pwmchip_remove(&pc->chip);
> > +	return 0;
> > +}
> 
> I forgot to mention this for ECAP, but you need to check the return
> value of pwmchip_remove() because there are situations where it can
> actually fail.

I will correct it.

Thanks
Avinash

> 
> Thierry
> 
