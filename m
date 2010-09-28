From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 28 Sep 2010 10:47:45 -0700
Subject: [PATCH 2/7] backlight:pwm: add an element 'name' to platform data
In-Reply-To: <1285659648-21409-3-git-send-email-arun.murthy@stericsson.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-3-git-send-email-arun.murthy@stericsson.com>
Message-ID: <20100928174744.GF10739@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 28, 2010 at 01:10:43PM +0530, Arun Murthy wrote:
> A new element 'name' is added to pwm backlight platform data structure.
> This is required to identify the pwm device.

> -	pb->pwm = pwm_request(data->pwm_id, "backlight");
> +	if (!data->name)
> +		data->name = "backlight";
> +	pb->pwm = pwm_request(data->pwm_id, data->name);

If we're going to go through and require that all PWM API users be
updated to take platform data for the name might it not be better to
switch over to the clock API style request by device interface?
