From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Tue, 13 Jul 2010 16:41:34 +0200
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100713141828.GB24260@rakim.wolfsonmicro.main>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<1279030173-3086-2-git-send-email-sundar.iyer@stericsson.com>
	<20100713141828.GB24260@rakim.wolfsonmicro.main>
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B1810E7E88D@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

>It is extremely disappointing to see you reposting this without engaging
>with my previous review at all.
Sincere apologies. As I said, I tried to repost after fixing your comments; but my
mistake that I didn't engage prior to the posting.

>> +static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
>> +	{ .dev = NULL, .supply = "vaux1", },
>> +};
>
>All these supplies with NULL devices are bogus, supplies are in terms of
>the device being supplied not the labels on the board.  If you've got a
>supply with no device and the name of the supply on either the regulator
>or the board you're most likely doing it wrong.  The only exception is
>for supplies used in cpufreq since we don't have a struct device we can
>use there.

I had these supplies as NULL, so that later on, when we add devices for our platform, 
each developer can edit this file to hook up his own device. The reason I wanted this
file in the patch set was to include the machine constraints for the regulators on AB8500.

As admitted earlier, I will wait for your valuable comments before posting the next patch set.
(Also, I will try to make sure(still learning) to post the next patches into the same thread.)

Regards,
Sundar
