From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 01 Dec 2014 17:23:45 +0000
Subject: [PATCH] ARM: imx6: fix bogus use of irq_get_irq_data
In-Reply-To: <1417454151.4624.29.camel@pengutronix.de>
References: <1417453443-9179-1-git-send-email-marc.zyngier@arm.com>
 <1417454151.4624.29.camel@pengutronix.de>
Message-ID: <547CA421.3050903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/14 17:15, Philipp Zabel wrote:
> Am Montag, den 01.12.2014, 17:04 +0000 schrieb Marc Zyngier:
>> The imx6 PM code seems to be quite creative in its use of irq_data,
>> using something something that is very much a hardware interrupt
>> number where we expect a virtual one.  Yes, it worked so far, but
>> that's only cheer luck, and it will definitely explode in 3.19.
>>
>> Fix it by using a pair of helper functions that deal with the
>> actual hardware.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks Fabio and Philipp for your prompt testing.

Arnd/Olof: Can you please queue these two patches? This is an issue
similar to the one found on Tegra last week, and this is going to
explode badly once the merge window opens.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
