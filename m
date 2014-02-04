From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Feb 2014 15:20:56 +0000
Subject: [PATCH 3/6] mfd: add bcm59056 pmu driver
In-Reply-To: <20140204150156.GC4627@beef>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-4-git-send-email-mporter@linaro.org>
 <20140204132951.GE13529@lee--X1> <20140204143119.GA4627@beef>
 <20140204144731.GA3154@lee--X1> <20140204150156.GC4627@beef>
Message-ID: <20140204152056.GB3154@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > ... then you'll still need this.
> 
> Yes, I was far too vague..I'm going to stop explicitly populating the
> data field.
> 
> static const struct of_device_id bcm59056_of_match[] = {
> 	{ .compatible = "brcm,bcm59056"},
> 	{ }
> };

+1

> > And I don't think you can drop this, as the I2C subsystem still
> > insists on it.
> 
> Agreed. I'm just dropping explicit population of the driver_data field
> here.
> 
> static const struct i2c_device_id bcm59056_i2c_id[] = {
> 	{ "bcm59056" },
> 	{ }
> };

+1

> > I think you need to keep this to supply the silly I2C ID table.
> > 
> > I would just omit the '.data = (void *) VERSION' from the
> > of_match_table until you require it. 
> 
> Well, it's not even necessary for I2C ID table. the I2C subsystem is
> happy with just a matching entry on the i2c_device_id name field and
> NULL driver_data. palmas is implemented in this manner.

Guess what? +1 :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
