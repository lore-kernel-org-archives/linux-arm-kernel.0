From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Jul 2012 12:12:26 +0100
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <50066739.4010206@linaro.org>
References: <50066739.4010206@linaro.org>
Message-ID: <20120718111226.GH22739@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 08:35:21AM +0100, Lee Jones wrote:

Fix your mailer to word wrap within paragraphs.  I've reformatted your
mail for legibility.

> I agree, but in this instance it really does stand to reason.

> 1. No unified bindings currently exist.
> 2. I don't have time to create them.
> 3. It will probably take quite a bit of time for someone else to get
>    round to creating them.
> 4. The bindings I'm proposing are siloed by vendor and driver, so will
>    cause no harm.

Right, this is just a restatement of the standard vendor line.

If the issue is purely about having generic bindings quite frankly it's
very hard to see how it could take much time or effort to handle the
generic bits for I2C, it's basically just the maximum bus frequency and
possibly also the various fast modes (though to a good approximation it
seems reasonable to just infer them from the bus frequency and then see
if we need any more).  One thing I frequently find is that people say
any sort of generic work is hard without explaining why, if there are
complex issues that's one thing but that's often not the case.

BTW, looking at the platform data again it seems like i2c_freq_mode it
seems very odd that it's driver specific?

> 5. I've already volunteered to move them over to the unified ones once
>    created.
> 6. These allow support for the driver to work with DT, at the moment
>    it does not.

> Personally, I think there is more to be gained by applying the
> (working) vendor specific bindings to the vendor specific driver until
> some more consolidated ones appear.

Again, vendors always make great promises about how they're going to
keep everything up to date...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120718/bfba9471/attachment.sig>
