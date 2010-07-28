From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 28 Jul 2010 12:02:26 -0400
Subject: [PATCH v3] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7D0AF64@dbde02.ent.ti.com>
References: <4C45AE5E.7070905@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7D0AF64@dbde02.ent.ti.com>
Message-ID: <4C505492.3060404@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 7/26/2010 5:29 AM, Nori, Sekhar wrote:
>
>
>> +
>> +static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
>> +    .bus_freq    = 100,    /* kHz */
>> +    .bus_delay    = 0,    /* usec */
>> +};
> This is exactly the pdata that davinci I2C driver uses by default,
> so you can save a few bytes and a few lines of code by passing NULL
> pdata.
>
> [...]
>

So I tried your suggestion and passed NULL as the pdata argument, e.g.,

...
ret = da8xx_register_i2c(0, NULL);
...

and the kernel locks up during initialization.  Did I not understand
what you were suggesting?  I will back this suggestion out until I get a chance
to hunt down the problem.  I see no other boards initialize the i2c this
way (they explicitly provide a structure).

Thanks.

-Mike
