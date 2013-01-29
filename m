From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue, 29 Jan 2013 09:43:13 +0100
Subject: [PATCH 3/4] watchdog: add support for ux500_wdt watchdog
In-Reply-To: <20130128211222.GA3338@spo001.leaseweb.com>
References: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
 <1358509214-22407-4-git-send-email-fabio.baltieri@linaro.org>
 <20130128211222.GA3338@spo001.leaseweb.com>
Message-ID: <20130129084313.GA20514@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wim,

thanks for the review!

On Mon, Jan 28, 2013 at 10:12:22PM +0100, Wim Van Sebroeck wrote:
> > +static int timeout = WATCHDOG_TIMEOUT;
> > +module_param(timeout, int, 0);
> > +MODULE_PARM_DESC(timeout,
> > +	"Watchdog timeout in seconds. default="
> > +				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
> 
> We should go for unsigned int timeout values...

You're right!  This ends up in an unsigned on the rest of the code
anyway and I see other drivers using it as unsigned so I'll change it in
v2 (here and in ux500_wdt_data).

> 
> > +static int nowayout = WATCHDOG_NOWAYOUT;
> > +module_param(nowayout, int, 0);
> > +MODULE_PARM_DESC(nowayout,
> > +	"Watchdog cannot be stopped once started (default="
> > +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> 
> nowayout is a boolean value so please change this to
> static bool nowayout = WATCHDOG_NOWAYOUT;

Right.

> The rest is OK by me. So if bowayout get's fixed then you have my acked-by.

Ok, I'll send a v2 of this patch soon with both parameters fixed for you
to ack.

Thanks!
Fabio

-- 
Fabio Baltieri
