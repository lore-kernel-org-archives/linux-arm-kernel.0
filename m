From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 17 Jul 2013 11:02:48 +0800
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <51E56AA7.7020103@wwwdotorg.org>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
 <20130716041056.GA30067@S2101-09.ap.freescale.net>
 <51E56AA7.7020103@wwwdotorg.org>
Message-ID: <20130717030246.GA4541@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 09:45:43AM -0600, Stephen Warren wrote:
> Registering the driver earlier won't cause any bugs. However, it's not
> the correct approach.
> 
> Deferred probe /is/ the approach for assuring correct dependencies
> between drivers. It works and should be used. There are not enough
> initcall levels to play games using initcalls and solve all the issues,
> and the ordering requirements vary board-to-board. Deferred probe at
> runtime handles this without having to manually place all the drivers
> into specific initcall levels, and dynamically adjusts to board
> differences, since it all happens automatically at run-time.

I do not quite follow the argument here.  I agree with you that
deferred probe is the approach to solve dependencies.  But it does not
necessarily mean that initcall can not be used to help it save some
nasty or nested deferring.  Deferred probe and initcalls are not two
mutually exclusive mechanisms but two which can help each other.

Shawn
