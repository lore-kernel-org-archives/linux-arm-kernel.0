From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Aug 2015 11:37:35 +0100
Subject: [PATCH v9 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <20150809151916.GF14271@lunn.ch>
References: <1437995567-11203-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438693367.3793.29.camel@pengutronix.de> <20150809151916.GF14271@lunn.ch>
Message-ID: <55C87EEF.6020609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 09/08/15 16:19, Andrew Lunn wrote:
> Hi Srinivas
>
> The AT24 eeprom driver contains the comment:
>
>          /*
>           * Export the EEPROM bytes through sysfs, since that's convenient.
>           * By default, only root should see the data (maybe passwords etc)
>           */
>
> and as you would expect from this:
>
> # ls -l ./devices/platform/soc/soc:aips-bus at 40000000/40066000.i2c/i2c-0/0-0050/eeprom
> -rw------- 1 root root 512 Aug  9 10:16 ./devices/platform/soc/soc:aips-bus at 40000000/40066000.i2c/i2c-0/0-0050/eeprom
>
> The AT25 and the MAX6875 driver are the same.
>
> However nvmem has different defaults:
>
> # ls -l ./devices/platform/soc/soc:aips-bus at 40000000/40066000.i2c/i2c-0/0-0050/0-00500/nvmem
> -rw-r--r-- 1 root root 0 Aug  9 10:16 ./devices/platform/soc/soc:aips-bus at 40000000/40066000.i2c/i2c-0/0-0050/0-00500/nvmem
>
Yes, nvmem by default sets the read permission for everyone S_IRUGO. 
Which was the most common use case.

> Has this been considered and discussed?
Thanks for bringing this up, No, we did not discuss this explicitly, but 
it should not be an issue to accommodate this. Provider still have 
flexibility to configure such things.

As a first patchset we wanted to keep the framework simple and add 
features as we move on.

Thanks,
srini
>
> Thanks
>      Andrew
>
