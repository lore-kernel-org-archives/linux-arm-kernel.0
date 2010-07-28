From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Jul 2010 08:41:49 -0700
Subject: [PATCH 4/4] sdhci-s3c: add regulator support
In-Reply-To: <4C504326.30708@gmail.com> (sfid-20100728_154813_432417_3ADF200E)
References: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com>
	<1280326797-15792-5-git-send-email-m.szyprowski@samsung.com>
	<4C504326.30708@gmail.com> (sfid-20100728_154813_432417_3ADF200E)
Message-ID: <3482ADFC-0FFB-47AE-B809-C88AC8B92C7F@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 Jul 2010, at 07:48, Maurus Cuelenaere <mcuelenaere@gmail.com> wrote:
>> 
>> +	struct sdhci_s3c *sc = sdhci_priv(host);
>> +
>> +	if (sc->vmmc) {
>> +		int ret = regulator_disable(sc->vmmc);
>> +		if (ret)
>> +			return ret;
>> +		mdelay(2);
> 
> Shouldn't these delays be handled in the regulator framework itself?

A 2ms delay on power down seems suspicious for a regulator. I'm not sure why this is required but if it is I suspect it's due to a large cap on the regulator output and light load rather than something that's always true for whatever regulator is providing the supply.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100728/cb7a4997/attachment-0001.html>
