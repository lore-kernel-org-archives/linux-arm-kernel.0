From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 27 Jan 2015 11:07:42 +0100
Subject: [PATCH v3 07/13] pm: at91: remove the config item
 CONFIG_AT91_SLOW_CLOCK
In-Reply-To: <20150127095515.GB32121@gradator.net>
References: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
 <1422338247-5945-1-git-send-email-wenyou.yang@atmel.com>
 <20150127095515.GB32121@gradator.net>
Message-ID: <20150127100742.GA15829@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27/01/2015 at 10:55:15 +0100, Sylvain Rochet wrote :
> Hello Wenyou,
> 
> On Tue, Jan 27, 2015 at 01:57:27PM +0800, Wenyou Yang wrote:
> >  
> >  static void __init at91_pm_init(void)
> >  {
> > -#ifdef CONFIG_AT91_SLOW_CLOCK
> >  	at91_pm_sram_init();
> > -#endif
> >  
> >  	pr_info("AT91: Power Management%s\n", (slow_clock ? " (with slow clock mode)" : ""));
> 
> Details, but the ternary operation can be removed here, slow_clock now 
> defines whether we have PM support at all, not whether we have 
> slow_clock mode available.
> 
> Maybe we should not even display this message on the console if we 
> failed to allocate sram for slow_clock, we already fired a message 
> saying that PM is not available at all in at91_pm_sram_init().
> 

That is done in patch 10/13.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
