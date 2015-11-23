From: songjun.wu@atmel.com (Wu, Songjun)
Date: Mon, 23 Nov 2015 11:01:54 +0800
Subject: [PATCH] ASoC: Atmel: ClassD: Set GCK's parent clock
In-Reply-To: <20151120180854.GD1929@sirena.org.uk>
References: <1447903590-3285-1-git-send-email-songjun.wu@atmel.com>
 <20151120180854.GD1929@sirena.org.uk>
Message-ID: <565281A2.4050500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/21/2015 02:08, Mark Brown wrote:
> On Thu, Nov 19, 2015 at 11:26:30AM +0800, Songjun Wu wrote:
>> Set GCK's parent clock as audio clock, make
>> sure the GCK's parent clock is audio clock.
>
>> +	ret = clk_set_parent(dd->gclk, dd->aclk);
>> +	if (ret) {
>> +		dev_err(dev, "failed to set GCK parent clock: %d\n", ret);
>> +		return ret;
>> +	}
>
> Why are we doing this in the driver?  This should be done by whatever
> creates the clock tree, not by the driver that uses the clocks - that
> way if some future SoC has a different clock tree the driver will
> continue to work.
>

You are right. The GCK's parent clock should be assigned in device tree, 
not in the driver. The DT binding for classD should be modified to set 
the GCK's parent clock as audio clock.
Thank you.
