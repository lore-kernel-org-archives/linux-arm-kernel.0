From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Apr 2016 13:55:57 -0700
Subject: [PATCH 2/2] [media] ir-rx51: Fix build after multiarch changes
 broke it
In-Reply-To: <572275DB.8090300@gmail.com>
References: <1461714709-10455-1-git-send-email-tony@atomide.com>
 <1461714709-10455-3-git-send-email-tony@atomide.com>
 <572266AF.9020601@gmail.com> <20160428202248.GG5995@atomide.com>
 <572275DB.8090300@gmail.com>
Message-ID: <20160428205557.GH5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160428 13:44]:
> ??,
> 
> On 28.04.2016 23:22, Tony Lindgren wrote:
> >* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160428 12:39]:
> >>On 27.04.2016 02:51, Tony Lindgren wrote:
> >>
> >>omap_dm_timer_request_specific always fails with message "Please use
> >>omap_dm_timer_request_by_cap/node()" with DT boot.
> >>
> >>I hacked the code to use omap_dm_timer_request_by_cap(OMAP_TIMER_HAS_PWM)
> >>and it seems to use the correct timer (IR LED blinks, checked with the
> >>camera of Samsung S4 mini), but it doesn't actually control either of the TV
> >>sets here. The same SW(pierogi) controls them when device is booted to stock
> >>kernel. However, this seems another problem not related to the patch.
> >
> >OK thanks for testing, I'll apply the pdata patch then.
> >
> >I assume you'll post a separate fix for the request_by_cap
> >driver change?
> >
> 
> Well, it was a hack, it just happens that the first matched timer is GPT9, I
> think we should aim for a proper solution (request_by_node()).
> 
> Shall I prepare a patch that gets the timer from the DT?

Sounds good to me!

Tony
