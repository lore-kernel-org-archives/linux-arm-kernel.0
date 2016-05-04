From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 May 2016 17:22:00 +0100
Subject: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
In-Reply-To: <87twiforl3.fsf@belgarion.home>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
 <20160503162938.GT6292@sirena.org.uk>
 <87twiforl3.fsf@belgarion.home>
Message-ID: <20160504162200.GX6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 09:43:20PM +0200, Robert Jarzmik wrote:

> You probably mean the BITCLK clock.

> What is a bit pesky about this clock is that it can either be mastered by
> digital controller and the codec is a slave, or the other way around.

That's a bit surprising - I've never encountered a system that
impelemnts this, it may be permitted by the spec but it's always the
CODEC.  The master clock from the CODEC is often provided by the SoC but
I've not seen systems where anything other than the CODEC drives the
actual AC'97 bus.

> >> +int ac97_digital_controller_register(const struct ac97_controller_ops *ops,
> >> +				     struct device *dev);
> >> +int ac97_digital_controller_unregister(const struct device *dev);

> > Why "digital"?

> I copy-pasted this from Audio Codec '97 Revision 2.3, where in several places
> they call the controller a "digital controller".

It's not really adding anything though, it's just clumsy wording on
their part - it's not like we need to distinguish this from analogue
or any other type of AC'97 controllers.

> Now if you prefer "ac97_controller" or something like that, that's as you wish,
> the name does not matter that much to me ;)

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160504/59b0edd1/attachment-0001.sig>
