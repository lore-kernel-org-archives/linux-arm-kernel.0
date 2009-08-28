From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 28 Aug 2009 08:11:08 +0200
Subject: [PATCH] watchdog: Add support for the Avionic Design Xanthos
	watchdog timer.
In-Reply-To: <20090827204448.GL29382@infomag.iguana.be>
References: <20090821073105.GC29382@infomag.iguana.be>
	<1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>
	<20090822081806.GD29382@infomag.iguana.be>
	<20090824090407.GA24894@avionic-design.de>
	<20090827202314.GJ29382@infomag.iguana.be>
	<4A96ED32.7000108@billgatliff.com>
	<20090827204448.GL29382@infomag.iguana.be>
Message-ID: <20090828061108.GA1649@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wim Van Sebroeck wrote:
> Hi Bill,
> 
> >> This is the only thing I'm still struggling with: the goal of a watchdog device driver is to make sure that the system reboots when the system isn't stable anymore. So why should you then trigger the interrupt?
> >>   
> >
> > ... because a hard reboot might not be the way he wants to resolve the  
> > situation.
> 
> If your system is unstable then sending a keepalive to the watchdog during
> this interrupt is not going to change anything neither... Or am I missing
> something?

In this case, writing the timeout value to the watchdog is not actually a
keepalive. This is in fact the mechanism used to reset/acknowledge the
watchdog's interrupt.

Thierry
