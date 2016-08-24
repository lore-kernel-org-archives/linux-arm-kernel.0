From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Aug 2016 12:39:53 +0100
Subject: [RFC PATCH v2 0/7] AC97 device/driver model revamp
In-Reply-To: <87twebphh4.fsf@belgarion.home>
References: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
 <87twebphh4.fsf@belgarion.home>
Message-ID: <20160824113953.GF22076@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 06:39:35PM +0200, Robert Jarzmik wrote:

> In the old ac97 bus, the match function was always returning "true", and the
> driver did probe. With this new implementation, the ac97 is discovered and
> sound/soc/codecs/wm9713.c#wm9713_ac97_probe() is called. I don't export
> ac97_bus_type (nor want to do it), and only _one_ device is created upon
> discovery, while the wm97xx-core.c would benefic a second ac97 device.

> I'm wondering how to work around this :
>  - either I add a wm97xx-ts ac97 device in wm9713_ac97_probe()
>  - or I add a platform device in wm9713_ac97_probe() and add a new
>    platform_driver in wm97xx-core ...
>  - or something smarter

That device really should be a MFD.

> What's behind this question is : should I keep to my initial solution of 1 ac97
> device discovered is bound on the ac97 to _at most_ 1 ac97 driver, or is there a
> know smart way to have several drivers for one device (that sounds a bit heretic
> regarding my understanding of the device/driver model but who knows ...) ?

MFDs are how we do multiple drivers per device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160824/63a791a6/attachment-0001.sig>
