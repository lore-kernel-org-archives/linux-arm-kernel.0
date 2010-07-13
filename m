From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Tue, 13 Jul 2010 16:34:56 +0200
Subject: [PATCH v2 1/2] regulator: add support for regulators on the
	ab8500 MFD
In-Reply-To: <20100713141709.GA24260@rakim.wolfsonmicro.main>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<20100713141709.GA24260@rakim.wolfsonmicro.main>
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B1810E7E880@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

>> + * @mask: mask to enable/disable regulator
>> + * @enable: bits to enable the regulator in normal(high power) mode
>Have you addressed my comments here?
Sorry that I couldn't inline my replies into the patch itself :(. I changed the comments for the variable
from the previous patch set. But I agree I messed up!

Yes. The mask here is different for the fact that we have two enable bits; enable LP(low power)
mode and enable HP(high power). We enable only the HP modes and hence the different mask
for enable/disable as well as for the enable.

>> +	ret = ab8500_get_best_voltage_index(rdev, min_uV, max_uV);
>> +	if (ret < 0) {
>> +		dev_dbg(rdev_get_dev(rdev),
>> +				"coudlnt get best voltage for regulator\n");
>
>Typo here.  Also, shouldn't your error messages be errors rather than
>debug output?
Yes. I will correct this.
