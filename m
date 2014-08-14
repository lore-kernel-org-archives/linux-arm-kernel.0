From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Aug 2014 12:47:38 +0200
Subject: [RFC PATCH v3] reset: Add a defer reset object to send board
 specific reset
In-Reply-To: <1408008998.4035.43.camel@paszta.hi.pengutronix.de>
References: <1403098673-3058-1-git-send-email-houcheng@gmail.com>
 <CACRpkdYfu8HmVCkn9JFh+YP5OPdr8o9nTfoCnkJ7SSpGoenQUg@mail.gmail.com>
 <20140708080535.GJ13423@lukather>
 <CACRpkdbFPAsu1gE-AVyD=-RxyE7mUJPSbFga7HLh0mxjE-mQuQ@mail.gmail.com>
 <1407507789.3354.20.camel@paszta.hi.pengutronix.de>
 <20140811173356.GN15297@lukather>
 <1408008998.4035.43.camel@paszta.hi.pengutronix.de>
Message-ID: <20140814104738.GV15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 11:36:38AM +0200, Philipp Zabel wrote:
> Hi Maxime,
> 
> Am Montag, den 11.08.2014, 19:33 +0200 schrieb Maxime Ripard:
> > > Mostly because Maxime and I seem to have a completely different opinion
> > > and nobody else argued one way or the other.
> > 
> > Yep, mostly because I don't see how a generic approach can work.
> > 
> > The existing reset-gpios property only provide the gpio to use, but
> > some informations are encoded in the driver, such as the reset
> > duration, or a reset sequence if any.
> 
> The driver should provide the duration.

How? This used to be in the code, and reset_control_reset doesn't take
such argument.

> I'd really like to see an example where sequencing is necessary.

Well, if you have several reset lines, the sequencing between each
might be important.

> I agree that as soon as things get significantly more complicated than
> pulsing a single GPIO, the reset-gpios binding is too limited.

While the generic reset bindings are perfect for that.

> Still, I'm not happy to mandate a separate gpio reset device for each
> reset line if most devices are simple enough for it to work without.

Well, it's pretty much already the case for other subsystems, such as
regulator.

I guess we can treat this as a legacy option, but allow the reset-gpio
code to be a full driver of its own, if we need more advanced use
cases?

> What about using reset-gpios for the majority of simple cases and have a
> separate gpio-reset-sequencer driver when multiple GPIO resets have to
> be timed?

I don't know. I feel like it should be in the driver itself, rather
than in a generic layer.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140814/36248234/attachment.sig>
