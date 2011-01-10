From: wim@iguana.be (Wim Van Sebroeck)
Date: Mon, 10 Jan 2011 14:58:10 +0100
Subject: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
In-Reply-To: <1294656906-24239-1-git-send-email-jamie@jamieiles.com>
References: <1294656906-24239-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110110135810.GN3801@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

> +config DW_WATCHDOG
> +	tristate "Synopsys DesignWare watchdog"
> +        select WATCHDOG_NOWAYOUT

I overlooked something: If your watchdog driver cannot be stopped once it's started,
then it's best to add a comment about that in your code. Selecting the WATCHDOG_NOWAYOUT
feauture (which is overall for all drivers) is not the way to do it properly.
What you should do is add a timer that ticks the watchdog if /dev/watchdog is closed.
Examples for this functionality can be found in at91sam9_wdt.c, pika_wdt.c, ...

Sorry,
Wim.
