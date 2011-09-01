From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 01 Sep 2011 13:18:32 +0200
Subject: [PATCH 1/5] ARM: Samsung: PWM: Allow to differentiate SoCs based
	on platform device name.
In-Reply-To: <CAH9JG2UiuaCyOk24hC=240ptQa8CKCVkXHaQzNt=YcnyQksnOA@mail.gmail.com>
References: <1731819.jJi37IsjvJ@flatron>
	<001d01cc684e$9c49ecd0$d4ddc670$%kim@samsung.com>
	<CAH9JG2UiuaCyOk24hC=240ptQa8CKCVkXHaQzNt=YcnyQksnOA@mail.gmail.com>
Message-ID: <1645899.rJz3R6pebo@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 of September 2011 at 12:33:10, Kyungmin Park wrote:
> On Thu, Sep 1, 2011 at 11:26 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Tomasz Figa wrote:
> >>
> >> 2011/8/31 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> >> > On Wed, Aug 31, 2011 at 02:34:15PM +0200, Tomasz Figa wrote:
> >> >
> >> >> This patch is a prerequisite to adding generic time support for
> > S3C64xx.
> >> >> It makes possible to differentiate SoCs, required to exclude timers 3
> > and 4
> >> >> from PWM driver only on S3C64xx.
> >> >
> >> > Now we have the cpu_is_foo() support for Samsung CPUs can we use that
> >> > instead?
> >>
> >> [snip]
> >
> > Hi Tomasz,
> >
> > You can use "soc_is_s3c64xx()" based on Samsung -next tree.
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > for-next
> 
> +static struct platform_device_id s3c_pwm_driver_ids[] = {
> +       {
> +               .name           = "s3c24xx-pwm",
> +               .driver_data    = TYPE_GENERIC,
> +       }, {
> +               .name           = "s3c64xx-pwm",
> +               .driver_data    = TYPE_S3C64XX,
> +       },
> +};
> +MODULE_DEVICE_TABLE(platform, s3c_pwm_driver_ids);
> 
> doesn't it right way?
> do you want to use the soc_is_* at device?
> 

Well, now we have three alternatives:
- to leave it as is (i.e. changing platform device names)
- to use cpu_is_* (does it ever exist for S3C64xx or soc_is_s3c64xx is its equivalent?)
- to use soc_is_* 

Waiting for more comments then.

Best regards,
Tom
