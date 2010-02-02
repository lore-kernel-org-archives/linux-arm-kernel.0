From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 2 Feb 2010 16:15:55 +0100
Subject: [PATCH 1/4] mfd: update i2c driver for max8925
In-Reply-To: <771cded01002020622v7fa47689je2a5b1c11e2bb0c7@mail.gmail.com>
References: <771cded01001250307o7e340a0dsf7e02762dad8c953@mail.gmail.com>
	<20100129195405.GB23130@sortiz.org>
	<771cded01002020622v7fa47689je2a5b1c11e2bb0c7@mail.gmail.com>
Message-ID: <20100202151554.GC28139@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Tue, Feb 02, 2010 at 09:22:58AM -0500, Haojian Zhuang wrote:
> On Fri, Jan 29, 2010 at 2:54 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> I wants to initialize max8925 after all three components probed. In
> core driver, irq handling needs to access all three components. In
> power supply driver, both adc and generic components are accessed.
> It's the reason that using three i2c clients in one driver.
Ok, that's what I understood. Adding appropriate comments to the code to
describe this would be really helpful.

 
> Yes, the code is not very clear. Now I use i2c_new_dummy() now. Now I
> attache new patches now.
> 
> Updates are in below.
> 1. use i2c_new_dummy() to replace i2c_new_probed_device().
> 2. add onkey driver
> 3. remove unused i2c pointer in rtc driver
Very good, I just have one last comment:


> @@ -142,27 +138,28 @@ static int __devinit max8925_probe(struct i2c_client *client,
>  				   const struct i2c_device_id *id)
>  {
>  	struct max8925_platform_data *pdata = client->dev.platform_data;
> -	struct max8925_chip *chip;
> +	static struct max8925_chip *chip;
That no longer needs to be static.
The rest of the code looks fine to me. Once you remove that static
definition, and you add some comments explaining why you need those 3 i2c
pointers, I'll merge it.

Thanks for your work.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
