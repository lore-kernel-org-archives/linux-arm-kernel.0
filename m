From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 15 Apr 2016 16:23:17 +0200
Subject: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
In-Reply-To: <20160415131146.GE3589@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
 <20160412102926.GC18882@ulmo.ba.sec> <20160415131146.GE3589@x1>
Message-ID: <20160415142317.GF3472@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 02:11:46PM +0100, Lee Jones wrote:
> On Tue, 12 Apr 2016, Thierry Reding wrote:
> > On Wed, Mar 02, 2016 at 03:32:05PM +0000, Lee Jones wrote:
> > [...]
> > > +struct sti_cpt_data {
> > > +	u32 snapshot[3];
> > > +	int index;
> > > +	int gpio;
> 
> [...]
> 
> > > +
> > > +		init_waitqueue_head(&data->wait);
> > > +		mutex_init(&data->lock);
> > > +		data->gpio = of_get_named_gpio(np, "capture-gpios", chan);
> > > +		pc->cpt_data[chan] = data;
> > 
> > Converting to per-PWM data should be as simple as turning this last line
> > into:
> > 
> > 	pwm_set_chip_data(pc->chip.pwms[chan], data);
> > 
> > Also I don't see any cleanup for this data in the driver. The memory for
> > the per-PWM data should be freed by devm_*() infrastructure, but how
> > will the GPIO be released?
> 
> There is no reason to release a GPIO.

Why? If you request it why would you not need to release it?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/54d45ab6/attachment-0001.sig>
