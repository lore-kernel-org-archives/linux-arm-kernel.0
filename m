From: sr@denx.de (Stefan Roese)
Date: Wed, 14 Mar 2012 14:43:57 +0100
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203141327.01038.arnd@arndb.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203141136.48513.sr@denx.de> <201203141327.01038.arnd@arndb.de>
Message-ID: <201203141443.57221.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012 14:27:00 Arnd Bergmann wrote:
> > > amba primecell devices don't actually need to register to a
> > > "compatible" property, they are probed using the primecell ID, and the
> > > device tree is just used to tell the system about memory and IRQ
> > > resources.
> > 
> > Ahh, I see. Let me see, if I can get this working...

Okay. Finally got it working. The main problem was the clock device name 
matching. Solved it via OF_DEV_AUXDATA. New patch will follow soon...
 
> I just saw that there is a patch series for pl061 that Rob Herring did at
> 
> git://sources.calxeda.com/kernel/linux.git irqdomain-for-grant
> 
> Please have a look at that branch first.

That's for GPIO interrupt support, right? I'll postpone this GPIO interrupt 
support to a later patch. This one will "only" support the plain GPIO's.
 
> > > Don't worry about the the gpio and uart devices if they are not in the
> > > first initial version. I do think that they should be done fairly soon
> > > though, before we get into most of the other devices.
> > > 
> > > It's ok if you put a lot of the other devices in the dts file though,
> > > like the ethernet device, it gives a better overview of what is
> > > actually there, even if the driver does not actually use it yet.
> > 
> > My initial idea was to push the devices once their DT support is
> > accepted. Otherwise the bindings are still not settled.
> 
> Right, that makes sense. However, you can add a property containing
> 
> 	status = "disabled;
> 
> so that the device is visible in the source but no platform device gets
> generated. That would have no consequences at run time but can be helpful
> for review.

Okay, I'll add all of what I got locally. And enable only the ones that should 
be fine.

Thanks,
Stefan
