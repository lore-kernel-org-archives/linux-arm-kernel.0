From: giometti@enneenne.com (Rodolfo Giometti)
Date: Tue, 17 Nov 2009 15:38:47 +0100
Subject: [PATCH] arm pxa: remove "direction input" forcing for IRQ GPIOs
In-Reply-To: <20091117130653.GX14091@buzzloop.caiaq.de>
References: <1258456906-12338-1-git-send-email-giometti@linux.it>
	<20091117114429.GT14091@buzzloop.caiaq.de>
	<20091117120501.GC8008@gundam.enneenne.com>
	<20091117123422.GU14091@buzzloop.caiaq.de>
	<20091117123721.GG8008@gundam.enneenne.com>
	<20091117124334.GW14091@buzzloop.caiaq.de>
	<20091117125953.GI8008@gundam.enneenne.com>
	<20091117130653.GX14091@buzzloop.caiaq.de>
Message-ID: <20091117143846.GK8008@gundam.enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 02:06:53PM +0100, Daniel Mack wrote:
> On Tue, Nov 17, 2009 at 01:59:53PM +0100, Rodolfo Giometti wrote:
> > On Tue, Nov 17, 2009 at 01:43:34PM +0100, Daniel Mack wrote:
> > > On Tue, Nov 17, 2009 at 01:37:21PM +0100, Rodolfo Giometti wrote:
> > > > On Tue, Nov 17, 2009 at 01:34:22PM +0100, Daniel Mack wrote:
> > > > > For such situations, the pullup/pulldown functions are normally used.
> > > > > Have you tried that?
> > > > 
> > > > Yes, the code has been tested on my board and it works perfectly.
> > > 
> > > What I mean is a mfp_cfg_t configuration as input pin with pull flags
> > > MFP_PULL_{HIGH,LOW} set.
> > 
> > I see... no I didn't noticed such possibility.
> > 
> > however I suppose that even using such flags my patch is needed in
> > order to avoid pxa_gpio_irq_type() forcing the input direction...
> 
> No, that's exactly my point. You don't need to set the pin to output
> direction to make use of those pull features. More than that, when
> confiugured as output, the pull flags actually don't make sense.

I just looking at pxa27x user manual but I don't see such pull-up
functionality... are you sure these settings aren't pxa3xx specific?
=:-o

Thanks,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
