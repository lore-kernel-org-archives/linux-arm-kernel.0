From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 4 Oct 2013 12:00:53 +0200
Subject: Timekeeping on at91rm9200 [Was: [PATCH v2] clockevents: Sanitize
 ticks to nsec conversion]
In-Reply-To: <20130924211139.GE16106@pengutronix.de>
References: <alpine.DEB.2.02.1309191629040.4089@ionos.tec.linutronix.de>
 <1380052223-24139-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130924211139.GE16106@pengutronix.de>
Message-ID: <524E91D5.5020804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/2013 23:11, Uwe Kleine-K?nig :
> Hello Nicolas, hello Jean-Christophe,
>
> I expect you should be able to revert
>
> 	b7a8ca5 (ARM: at91: rm9200 fix time support)
>
> which reverted
>
> 	838a2ae (ARM: use clockevents_config_and_register() where possible)
>
> for at91rm9200 on top of the patch this mail is a reply to.
>
> Can you please test that?

I have just tested that on at91rm9200-ek:
- revert the revert (!)
- experience the crash
- then apply the v2 patch
- and finally see it working nicely!

Thanks a lot for having corrected this. Now, do you want that I stack 
this revert-of-revert on the AT91 git tree or you are able to apply it 
through the clock git tree together with the patch that is fixing the 
issue (it may prevent synchronization difficulties)? (BTW, I do not see 
it yet in "next").

Anyway, if it is required, you can add my:

Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye,
-- 
Nicolas Ferre
