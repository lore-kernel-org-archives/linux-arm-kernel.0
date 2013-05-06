From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 6 May 2013 10:43:23 +0300
Subject: [PATCH 4/4] staging: =?utf-8?Q?ste=5Fr?=
 =?utf-8?Q?mi4=3A_Suppress_'ignoring_return_value_of_=E2=80=98regulator=5F?=
 =?utf-8?B?ZW5hYmxlKCkn?= warning
In-Reply-To: <20130506065138.GA31763@bnru10>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
 <1367509690-24022-5-git-send-email-lee.jones@linaro.org>
 <20130503070713.GA27956@bnru09> <20130505141855.GB4686@mwanda>
 <20130506065138.GA31763@bnru10>
Message-ID: <20130506074323.GH4635@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 06, 2013 at 12:21:39PM +0530, Srinidhi Kasagar wrote:
> > > > -	regulator_enable(rmi4_data->regulator);
> > > > +	retval = regulator_enable(rmi4_data->regulator);
> > > > +	if (retval < 0)
> > > > +		return retval;
> > > Does it make sense to add a dev_err?
> > > 
> > 
> > Is that a question?
> > 
> > regulator_enable() already prints some warnings.  Probably it's not
> > going to fail and adding code that is duplicative or will never be
> > run is pointless.
> 
> It has become a habit checking the return value and spit some errors.
> And BTW, there are many drivers which does this way..Anyway if your
> intention is to avoid them for the new drivers..I dont mind skipping
> this..

It's not like I'm trying to ban error messages.  There isn't any
official policy on error messages.

regards,
dan carpenter
