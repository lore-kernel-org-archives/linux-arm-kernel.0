From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed, 28 Jul 2010 19:06:22 +0200
Subject: [PATCH 4/4] sdhci-s3c: add regulator support
In-Reply-To: <3482ADFC-0FFB-47AE-B809-C88AC8B92C7F@opensource.wolfsonmicro.com>
References: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com>
	<1280326797-15792-5-git-send-email-m.szyprowski@samsung.com>
	<4C504326.30708@gmail.com> (sfid-20100728_154813_432417_3ADF200E)
	<3482ADFC-0FFB-47AE-B809-C88AC8B92C7F@opensource.wolfsonmicro.com>
Message-ID: <4C50638E.7010101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 28-07-10 17:41, Mark Brown schreef:
> On 28 Jul 2010, at 07:48, Maurus Cuelenaere <mcuelenaere@gmail.com> wrote:
>>> +	struct sdhci_s3c *sc = sdhci_priv(host);
>>> +
>>> +	if (sc->vmmc) {
>>> +		int ret = regulator_disable(sc->vmmc);
>>> +		if (ret)
>>> +			return ret;
>>> +		mdelay(2);
>> Shouldn't these delays be handled in the regulator framework itself?
> A 2ms delay on power down seems suspicious for a regulator. I'm not sure why this is required but if it is I suspect it's due to a large cap on the regulator output and light load rather than something that's always true for whatever regulator is providing the supply.

I wasn't suggesting to do the delay in the framework *itself*, rather in the
regulator driver and/or the board platform code which needs this delay.

-- 
Maurus Cuelenaere
