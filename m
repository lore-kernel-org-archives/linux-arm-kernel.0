From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 16 Nov 2018 11:22:49 +0200
Subject: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
In-Reply-To: <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
Message-ID: <1391bbe1-75b5-c86e-ed3a-1e1afb393917@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

On 11/16/2018 08:52 AM, Uwe Kleine-K?nig wrote:
> Regarding the .request case: The consumer might be interested in taking
> over the configured state from the boot loader. So the initially
> configured state should be retained.
> 
> For the free case the PWM consumer is responsible to disable the PWM
> before calling pwm_release and there are three subcases to consider:
> 

the changes are fine per se, but please split them into two.

Probably pwm_disable() misusage began spreading from commit 54b2a999a1675.

--
Best wishes,
Vladimir
