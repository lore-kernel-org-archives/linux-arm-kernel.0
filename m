From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 May 2014 20:17:47 -0500
Subject: [PATCH 4/7] usb: ehci-platform: add optional reset controller
 retrieval
In-Reply-To: <Pine.LNX.4.44L0.1405081002190.1087-100000@iolanthe.rowland.org>
References: <536B324C.1040806@redhat.com>
 <Pine.LNX.4.44L0.1405081002190.1087-100000@iolanthe.rowland.org>
Message-ID: <20140510011747.GI7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 10:07:25AM -0400, Alan Stern wrote:
> On Thu, 8 May 2014, Hans de Goede wrote:
> 
> > Hi,
> > 
> > On 05/08/2014 12:00 AM, Maxime Ripard wrote:
> > > On Wed, May 07, 2014 at 10:25:55AM -0400, Alan Stern wrote:
> > >> On Tue, 6 May 2014, Maxime Ripard wrote:
> > >>
> > >>> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > >>>
> > >>> On the Allwinner's A31 SoC the reset line connected to the EHCI IP has to
> > >>> be deasserted for the EHCI block to be usable.
> > >>>
> > >>> Add support for an optional reset controller that will be deasserted on
> > >>> power off and asserted on power on.
> > >>>
> > >>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > >>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > >>
> > >> Is this really a _reset_ line?  That is, when you assert the reset 
> > >> line, does it actually reset the EHCI controller, or does it merely 
> > >> leave the controller in a partially powered-down state?
> > > 
> > > It actually resets the whole controller.
> > > 
> > >> The difference is important.  During suspend, the controller is
> > >> supposed to remember the state of the port connections as well as other
> > >> settings.  If it doesn't, the controller and all attached USB devices
> > >> will have to be reinitialized every time the controller resumes, which
> > >> will increase the latency.
> > > 
> > > So you're saying that we should move this to the probe then?
> > 
> > Yes.
> 
> That's right.  The controller should not be reset during suspend, if
> you can possibly avoid it.
> 
> There isn't any real benefit to asserting the reset signal during 
> suspend, is there?  I mean, it won't use any less power, right?

I don't think it will. I'll update the patches and send a new version.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/8145003e/attachment.sig>
