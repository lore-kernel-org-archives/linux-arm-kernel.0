From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Apr 2016 14:11:46 +0100
Subject: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
In-Reply-To: <20160412102926.GC18882@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
 <20160412102926.GC18882@ulmo.ba.sec>
Message-ID: <20160415131146.GE3589@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2016, Thierry Reding wrote:
> On Wed, Mar 02, 2016 at 03:32:05PM +0000, Lee Jones wrote:
> [...]
> > +struct sti_cpt_data {
> > +	u32 snapshot[3];
> > +	int index;
> > +	int gpio;

[...]

> > +
> > +		init_waitqueue_head(&data->wait);
> > +		mutex_init(&data->lock);
> > +		data->gpio = of_get_named_gpio(np, "capture-gpios", chan);
> > +		pc->cpt_data[chan] = data;
> 
> Converting to per-PWM data should be as simple as turning this last line
> into:
> 
> 	pwm_set_chip_data(pc->chip.pwms[chan], data);
> 
> Also I don't see any cleanup for this data in the driver. The memory for
> the per-PWM data should be freed by devm_*() infrastructure, but how
> will the GPIO be released?

There is no reason to release a GPIO.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
