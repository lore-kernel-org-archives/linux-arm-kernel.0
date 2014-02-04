From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Feb 2014 17:08:32 +0000
Subject: [PATCH 3/6] mfd: add bcm59056 pmu driver
In-Reply-To: <20140204165906.GC22609@sirena.org.uk>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-4-git-send-email-mporter@linaro.org>
 <20140204132951.GE13529@lee--X1> <20140204143119.GA4627@beef>
 <20140204165906.GC22609@sirena.org.uk>
Message-ID: <20140204170832.GA5196@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > +static struct i2c_driver bcm59056_i2c_driver = {
> > > > +	.driver = {
> > > > +		   .name = "bcm59056",
> > > > +		   .owner = THIS_MODULE,
> > > > +		   .of_match_table = of_match_ptr(bcm59056_of_match),
> 
> > > No need to use of_match_ptr() here.
> 
> > Will remove.
> 
> What using of_match_ptr() should do is allow the compiler to figure out
> that the table isn't used when DT is disabled and discard it without
> ifdefs.  Not sure if that actually works yet but that's the idea.

Right, but I'm guessing that as there is no support for platform data
then this device(s) is going to be DT only? If that's the case perhaps
a 'depends OF' might be in order. If that's not the case then I'm more
than happy to leave the of_match_ptr() in.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
