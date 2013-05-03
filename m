From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 3 May 2013 08:11:42 +0100
Subject: [PATCH 4/4] staging: =?utf-8?Q?ste=5Fr?=
 =?utf-8?Q?mi4=3A_Suppress_'ignoring_return_value_of_=E2=80=98regulator=5F?=
 =?utf-8?B?ZW5hYmxlKCkn?= warning
In-Reply-To: <20130503070713.GA27956@bnru09>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
 <1367509690-24022-5-git-send-email-lee.jones@linaro.org>
 <20130503070713.GA27956@bnru09>
Message-ID: <20130503071142.GB24153@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 May 2013, Srinidhi Kasagar wrote:

> On Thu, May 02, 2013 at 17:48:10 +0200, Lee Jones wrote:
> > drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c:
> >         In function ?synaptics_rmi4_resume?:
> > drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c:1090:18:
> >         warning: ignoring return value of ?regulator_enable?, declared
> >         with attribute warn_unused_result [-Wunused-result
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: devel at driverdev.osuosl.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
> > index fe667dd..c4d013d 100644
> > --- a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
> > +++ b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
> > @@ -1087,7 +1087,9 @@ static int synaptics_rmi4_resume(struct device *dev)
> >  	unsigned char intr_status;
> >  	struct synaptics_rmi4_data *rmi4_data = dev_get_drvdata(dev);
> >  
> > -	regulator_enable(rmi4_data->regulator);
> > +	retval = regulator_enable(rmi4_data->regulator);
> > +	if (retval < 0)
> > +		return retval;
> Does it make sense to add a dev_err?

Yes, I can do that.

> Otherwise, you can add my
> Acked-by:srinidhi kasagar <srinidhi.kasagar@stericsson.com> for this series.

Thanks.

> >  
> >  	enable_irq(rmi4_data->i2c_client->irq);
> >  	rmi4_data->touch_stopped = false;

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
