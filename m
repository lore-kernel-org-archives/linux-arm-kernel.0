From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu, 24 Dec 2015 20:38:24 +0100
Subject: [PATCH 5/6] ARM: LG Optimus Black (P970) codename sniper
 support, with basic features
In-Reply-To: <20151223154455.GL2793@atomide.com>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-6-git-send-email-contact@paulk.fr>
 <20151223154455.GL2793@atomide.com>
Message-ID: <1450985904.11913.6.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le mercredi 23 d?cembre 2015 ? 07:44 -0800, Tony Lindgren a ?crit :
> * Paul Kocialkowski <contact@paulk.fr> [151223 03:00]:
> > +&gpio1 {
> > +	ti,no-reset-on-init;
> > +};
> > +
> > +&gpio2 {
> > +	ti,no-reset-on-init;
> > +};
> > +
> > +&gpio3 {
> > +	ti,no-reset-on-init;
> > +};
> > +
> > +&gpio4 {
> > +	ti,no-reset-on-init;
> > +};
> > +
> > +&gpio5 {
> > +	ti,no-reset-on-init;
> > +};
> > +
> > +&gpio6 {
> > +	ti,no-reset-on-init;
> > +};
> 
> Care to try to narrow down exactly which GPIO(s) need to be preserved?
> Chances are this will unnecessarily block deeper idle states in hardware
> otherwise.
> 
> My guess is that the GPIO pins that need to be preserved if any are in
> the GPIO bank 1 as that's always powered..

Well, I actually need to keep the GPIOs handling backlight control,
buttons LEDs and the micro USB connector muxing (which can be set to
UART or USB). Those are spread accross gpio2, gpio5 and gpio6, so I'll
only enable these in v2.

Thanks for the review!

-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/a449e57d/attachment.sig>
