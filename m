From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 15 Mar 2017 12:23:00 +0000
Subject: [PATCH 23/35] drivers/mfd: Convert remaining uses of pr_warning
 to pr_warn
In-Reply-To: <1489511868.2582.2.camel@perches.com>
References: <cover.1487314666.git.joe@perches.com>
 <a6c827c14d0b9f4be42e549ec4c629245516e979.1487314667.git.joe@perches.com>
 <20170314140455.umlhdbuj3grqtu6i@dell>
 <1489511868.2582.2.camel@perches.com>
Message-ID: <20170315122300.jwuogngm6obgvz5z@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Mar 2017, Joe Perches wrote:

> On Tue, 2017-03-14 at 14:04 +0000, Lee Jones wrote:
> > On Thu, 16 Feb 2017, Joe Perches wrote:
> > > To enable eventual removal of pr_warning
> []
> > > diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> []
> > > @@ -502,9 +502,7 @@ static int load_twl4030_script(const struct twl4030_power_data *pdata,
> > >  	}
> > >  	if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
> > >  		if (!order)
> > > -			pr_warning("TWL4030: Bad order of scripts (sleep "\
> > > -					"script before wakeup) Leads to boot"\
> > > -					"failure on some boards\n");
> > > +			pr_warn("TWL4030: Bad order of scripts (sleep script before wakeup) Leads to boot failure on some boards\n");
> > 
> > Is 80 chars considered the lessor sin?
> 
> Splitting logging messages into multiple lines is non preferred.
> 
> Documentation/process/coding-style.rst:
> 
> Breaking long lines and strings:
> 
> never break user-visible strings such as
> printk messages, because that breaks the ability to grep for them.

Right, I'm aware of this.  I'm also aware of the other rule we have
where lines are not to exceed 80 chars.  Hence my question; "is the 80
chars rule the lessor sin of the two".

Rock <=> hard place

Actually I would say that the error message sub-optimal and could, in
fact be edited to be more succinct, thus not breaking any rules. 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
