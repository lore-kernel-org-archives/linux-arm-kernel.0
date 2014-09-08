From: philippe.retornaz@gmail.com (=?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?=)
Date: Mon, 08 Sep 2014 14:06:36 +0200
Subject: [PATCH] mfd: mc13xxx: Configure WDI reset
In-Reply-To: <20140908092559.GB24081@pengutronix.de>
References: <1410159671-25873-1-git-send-email-mpa@pengutronix.de>
 <540D5DEB.6020605@gmail.com> <20140908092559.GB24081@pengutronix.de>
Message-ID: <540D9BCC.2000801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/09/2014 11:25, Markus Pargmann a ?crit :
> Hi,
>
> On Mon, Sep 08, 2014 at 09:42:35AM +0200, Philippe R?tornaz wrote:
>> Hello
>>
>> Le 08/09/2014 09:01, Markus Pargmann a ?crit :
>>> Setup the PMIC to make a restart when a watchdog interrupt occures.
>>> If this is not configured, the PMIC will shut down the power supply
>>> without a restart.
>>
>>
>> Well, this was used to poweroff the mx31moboard board.
>> So we need to be able to configure the functionality.
>
> So on mx31moboard the watchdog interrupt always leads to a poweroff instead of
> a reset?

Well, no, it simply doesn't work since the output pin is not enabled :)
We enable the watchdog output only in pm_power_off().

> Perhaps it would be better to switch back to poweroff on
> watchdog interrupt right before the shutdown watchdog interrupt is
> triggered.

Yes, we definitely should be doing this.
The only point is that we don't have currently access to the PMIC from 
pm_power_off().
Is there a clean/recommended way to do it ?

Thanks !

Philippe
