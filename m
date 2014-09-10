From: johan@kernel.org (Johan Hovold)
Date: Wed, 10 Sep 2014 17:52:36 +0200
Subject: [PATCH 5/5] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <20140910173114.593dd132@bbrezillon>
References: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
 <1409733934-14465-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140910121424.GG2974@localhost>
 <20140910152019.111c4c01@bbrezillon>
 <20140910150702.GK2974@localhost>
 <20140910173114.593dd132@bbrezillon>
Message-ID: <20140910155236.GL2974@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 05:31:14PM +0200, Boris BREZILLON wrote:
> On Wed, 10 Sep 2014 17:07:02 +0200
> Johan Hovold <johan@kernel.org> wrote:

> > Yes, this essentially what I suggested in the thread (and my last reply)
> > and relying on syscon rather than a custom driver seems like a good
> > idea. It would allow early access to the registers too with the recently
> > proposed changes. It would not guarantee any kind of exclusivity,
> > though, but I guess that's tolerable?
> 
> Yep, that's one of the concern I had with the syscon/regmap
> approach :-(, but I guess I'll give this solution a try and post a new
> version of this series ;-).

Perhaps we should see what Nicolas and Jean-Christophe says before
rushing into anything (again). ;)

I remember J-C considered loosing track of what was using a particular
backup register to be a regression. But I guess you can't have it both
ways (e.g. if you also want the early access soon provided by syscon).

I'll refresh my rtt and gmbr-node patches meanwhile, as they should be
needed in some form at least.

> Can we just leave the rtt as an rtc problem on the side for now and bind
> it to the rtc-at91sam9 driver.
> 
> If we ever decide to add a new driver using the RTT for another purpose
> we will still be able to reference the RTT block like this (and keep
> the existing rtt node definition):
> 
> rtt-based-rtc {
> 	compatible = "atmel,rtt-rtc";
> 	atmel,rtt = <&rtt>;
> 	atmel,time-reg = <&gpbr 0x0>;
> }

But why not do this from the start?

> rtt-based-xdev {
> 	compatible = "atmel,rtt-xdev";
> 	atmel,rtt = <&rtt>;
> 	/*...*/
> }

Johan
