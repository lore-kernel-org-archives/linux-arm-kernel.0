From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 13 Oct 2010 13:24:26 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <201010132210.17061.arnd@arndb.de>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<201010132145.30550.arnd@arndb.de>
	<1286999522.28336.15.camel@c-dwalke-linux.qualcomm.com>
	<201010132210.17061.arnd@arndb.de>
Message-ID: <1287001466.28336.31.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-13 at 22:10 +0200, Arnd Bergmann wrote:
> On Wednesday 13 October 2010 21:52:02 Daniel Walker wrote:
> > > Seriously, I don't think you need it, but if you really do, we can probably
> > > find a way to work around this by changing the base hvc driver.
> > 
> > I think we would have to add something that allows different major/minor
> > numbers, because something that includes the name "Hypervisor" shouldn't
> > be used for something general.. /dev/hvcX is also registered for "IBM
> > iSeries/pSeries virtual console" (according to www.lanana.org) which is
> > confusing ..
> 
> That only means we need to update the lanana entry now that the hvc driver
> is used on nine different platforms (not including yours) instead of ust
> pSeries. Feel free to come up with a backronym for HVC if you're
> uncomfortable with the old "hypervisor console" name.

If you read back in this thread you'll see how there was a discussion
already on how you shouldn't re-use major/minor numbers for other
purposes .. It looks like "hvc" was essentially overridden , which now
seems like a no-no given that discussion.. This appears to be a
sensitive topic.

It can't hurt anything to make this hvc driver a little more flexible in
this regard ..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
