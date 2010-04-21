From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 22 Apr 2010 07:11:34 +1000
Subject: [RFC/PATCH] dns323: Support for HW rev C1
In-Reply-To: <alpine.LFD.2.00.1004211030510.7232@xanadu.home>
References: <1271838486.2330.139.camel@pasglop>
	<1271838700.2330.143.camel@pasglop>
	<alpine.LFD.2.00.1004211030510.7232@xanadu.home>
Message-ID: <1271884294.2330.160.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-04-21 at 10:32 -0400, Nicolas Pitre wrote:
> > Oh a couple more things...
> > 
> > The fans are controlled via 2 GPIOs on this (see the explanation in
> the
> > patch). Do you guys think I should create some kind of pseudo hwmon
> > device so it can be controlled with one file where you write "off",
> > "low", "high", or should I just let userspace cope.
> 
> If you fancy doing such thing then that would be more user friendly.  
> And that could provide a common abstraction for all models. 

Well, other models have an i2c fan controller that is supported by
hwmon, so I'm not sure it's necessarily -that- a good idea to change
that (but then I've never been a fan of hwmon either :-)

I'm half tempted to actually stick a thermal control kernel thread in
there and leave userspace out of the game too, like I do on most macs. 

I'll think about it. No time right now anyways.

Cheers,
Ben.
