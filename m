From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 14 May 2013 07:05:13 -0400
Subject: [PATCH 4/4] staging: =?utf-8?Q?ste=5Fr?=
 =?utf-8?Q?mi4=3A_Suppress_'ignoring_return_value_of_=E2=80=98regulator=5F?=
 =?utf-8?B?ZW5hYmxlKCkn?= warning
In-Reply-To: <20130514104631.GA28781@gmail.com>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
 <1367509690-24022-5-git-send-email-lee.jones@linaro.org>
 <20130514104631.GA28781@gmail.com>
Message-ID: <20130514110513.GA10354@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 11:46:31AM +0100, Lee Jones wrote:
> Hi Greg,
> 
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
> >  
> >  	enable_irq(rmi4_data->i2c_client->irq);
> >  	rmi4_data->touch_stopped = false;
> 
> Are you planning to take this into the v3.10 -rcs?

Yes, I was, give me some time to catch up on my pending patch queue (644
patches and counting).  Don't worry, it's not lost.

thanks,

greg k-h
