From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 17 Nov 2014 16:01:31 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <20141117145545.GC7046@atomide.com>
References: <20141116075928.GA9763@amd> <20141117101553.GA21151@amd>
 <20141117145545.GC7046@atomide.com>
Message-ID: <201411171601.32311@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 November 2014 15:55:46 Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [141117 02:17]:
> > On Mon 2014-11-17 11:09:45, Pali Roh?r wrote:
> > > On Monday 17 November 2014 11:05:19 Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > On Mon 2014-11-17 09:43:19, Pali Roh?r wrote:
> > > > > On Sunday 16 November 2014 08:59:28 Pavel Machek wrote:
> > > > > > For device tree people: Yes, I know I'll have to
> > > > > > create file in documentation, but does the binding
> > > > > > below look acceptable?
> > > > > > 
> > > > > > I'll clean up driver code a bit more, remove the
> > > > > > printks. Anything else obviously wrong?
> > > > > 
> > > > > I think that this patch is probably not good and
> > > > > specially not for n900. adp1653 should be registered
> > > > > throw omap3 isp camera subsystem which does not have
> > > > > DT support yet.
> > > > 
> > > > Can you explain?
> > > > 
> > > > adp1653 is independend device on i2c bus, and we have
> > > > kernel driver for it (unlike rest of n900 camera
> > > > system). Just now it is unusable due to lack of DT
> > > > binding. It has two functions, LED light and a camera
> > > > flash; yes, the second one should be integrated to the
> > > > rest of camera system, but that is not yet merged. That
> > > > should not prevent us from merging DT support for the
> > > > flash, so that this part can be tested/maintained.
> > > 
> > > Ok. When ISP camera subsystem has DT support somebody will
> > > modify n900 DT to add camera flash from adp1653 to ISP...
> > > I believe it will not be hard.
> > 
> > Exactly. And yes, I'd like to get complete camera support
> > for n900 merged. But first step is "make sure existing
> > support does not break".
> 
> There's nothing stopping us from initializing the camera code
> from pdata-quirks.c for now to keep it working. Certainly the
> binding should be added to the driver, but that removes a
> dependency to the legacy booting mode if things are otherwise
> working.
> 
> Regards,
> 
> Tony

Tony, legacy board code for n900 is not in mainline tree. And 
that omap3 camera subsystem for n900 is broken since 3.5 
kernel... (both Front and Back camera on n900 show only green 
picture).

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/f4aa7e86/attachment-0001.sig>
