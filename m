From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Oct 2013 22:01:42 +0200
Subject: [PATCHv4] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <20131022153445.GD17512@ns203013.ovh.net>
References: <20131019104555.GI18477@ns203013.ovh.net>
 <1382346813-8449-1-git-send-email-denis@eukrea.com>
 <20131022045833.GB17512@ns203013.ovh.net>
 <20131022072307.GA8681@ulmo.nvidia.com>
 <20131022153445.GD17512@ns203013.ovh.net>
Message-ID: <20131022200141.GA8037@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 05:34:45PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 09:23 Tue 22 Oct     , Thierry Reding wrote:
> > On Tue, Oct 22, 2013 at 06:58:33AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 11:13 Mon 21 Oct     , Denis Carikli wrote:
> > > > Cc: Richard Purdie <rpurdie@rpsys.net>
> > > > Cc: Jingoo Han <jg1.han@samsung.com>
> > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > > Cc: Pawel Moll <pawel.moll@arm.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > > > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > > > Cc: devicetree at vger.kernel.org
> > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > Cc: linux-arm-kernel at lists.infradead.org
> > > > Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> > > > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > > > Cc: Eric B?nard <eric@eukrea.com>
> > > > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > > > ---
> > > > ChangeLog v3->v4:
> > > > - The default-brightness property is now optional, it defaults to 1 if not set.
> > > by default we set OFF not ON
> > > 
> > > do not actiate driver or properti by default you can not known to consequence
> > > on the hw
> > 
> > Turning on a backlight by default is what pretty much every backlight
> > driver does. I personally think that's the wrong default, I even tried
> > to get some discussion started recently about how we could change this.
> > However, given that this has been the case for possibly as long as the
> > subsystem has existed, suddenly changing it might cause quite a few of
> > our users to boot the new kernel and not see their display come up. As
> > with any other ABI, this isn't something we can just change without a
> > very good migration path.
> 
> I'm sorry but the blacklight descibe in DT have nothing to do with the common
> pratice that the current driver have today

That's not at all what I said. What I said was that the majority of
backlight drivers currently default to turning the backlight on when
probed. Therefore I think it would be consistent if this driver did the
same.

I also said that I don't think it's a very good default, but at the same
time we can't just go and change the default behaviour at will because
people may rely on it.

> put on by default if wrong specially without the property define. Even put it
> on by default it wrong as the bootloader may have set it already for splash
> screen and to avoid glitch the drivers need to detect this.

I agree that would be preferable, but I don't know of any way to detect
what value the bootloader set a GPIO to. The GPIO API requires that you
call gpio_direction_output(), and that requires a value parameter which
will be used as the output level of the GPIO.

> For me this should not even be a property but handled by the driver them
> selves in C.

Agreed. There has been some discussion recently about whether devicetree
should be extended (or supplemented) to allow defining behaviour as well
(in addition to just hardware). But that's not immediately relevant here
at this time.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/60b1153e/attachment-0001.sig>
