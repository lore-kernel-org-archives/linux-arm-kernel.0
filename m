From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 24 Feb 2014 10:03:30 -0800
Subject: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <20140221081603.GA3931@lukather>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20140221081603.GA3931@lukather>
Message-ID: <20140224180330.GD32621@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 21 Feb 00:16 PST 2014, Maxime Ripard wrote:

> Hi Bjorn,
> 
> On Thu, Feb 20, 2014 at 04:38:10PM -0800, Bjorn Andersson wrote:
> > +static int qup_i2c_probe(struct platform_device *pdev)
> > +{
> 
> [ snip ]
> 
> > +
> > +	qup_i2c_enable_clocks(qup);
> > +
> 
> [ snip ]
> 
> > +
> > +	pm_runtime_set_autosuspend_delay(qup->dev, MSEC_PER_SEC);
> > +	pm_runtime_use_autosuspend(qup->dev);
> > +	pm_runtime_enable(qup->dev);
> 
> Since the device is already woken up, you probably need to call
> pm_runtime_set_active here.

Thanks.

> 
> Maxime

Regards,
Bjorn
