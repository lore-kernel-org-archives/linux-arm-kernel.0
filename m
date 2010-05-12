From: rubini@unipv.it (Alessandro Rubini)
Date: Wed, 12 May 2010 23:08:46 +0200
Subject: [PATCH 1/2] nomadik hwrng: Add clock support
In-Reply-To: <1273697274.15067.1136.camel@calx>
References: <1273697274.15067.1136.camel@calx>
	<1273560944-13243-1-git-send-email-srinidhi.kasagar@stericsson.com>
Message-ID: <20100512210846.GA19831@morgana.i.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Looks good to me. Herbert, please queue this.

There are two details wrong, I hope Srinidhi sent V2 soon after this V1.

>> +struct clk *rng_clk;

This should be static.

The other problem is that there is no clock associated to this device,
it is only added by the later 2/2 patch.  So the rng stops working
with this patch alone, with this error:

>> +	rng_clk = clk_get(&dev->dev, NULL);
>> +	if (IS_ERR(rng_clk)) {
>> +		dev_err(&dev->dev, "could not get rng clock\n");
>> +		ret = PTR_ERR(rng_clk);
>> +		return ret;
>> +	}

I think the two patches  must be split differently. However, it's just
two minor details, so I am not against applying as-is, if the relevant
maintainer chooses to.

Thanks
/alessandro
