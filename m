From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Nov 2012 14:19:35 +0000
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <CACRpkdawAdbwackZeST4iDkFZx9-exhTVoUzAABaWr1G89tATg@mail.gmail.com>
References: <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <CACRpkdaiLXVeUg1quuw3XPTenbKOjn+aWbGQezpcyvzQCtCWow@mail.gmail.com>
 <20121030113407.GA24335@sirena.org.uk>
 <CACRpkdapQJY0aoam741O0fb8EeM9BLk_Psq5TaPG84J7wEvCLw@mail.gmail.com>
 <87obji8kta.fsf@deeprootsystems.com>
 <CACRpkdbCk9+HSBPtfT-1dO8paSRYJ5VXX_0SxiyxgrObnJEvmQ@mail.gmail.com>
 <20121101120713.GA4413@opensource.wolfsonmicro.com>
 <CACRpkdawAdbwackZeST4iDkFZx9-exhTVoUzAABaWr1G89tATg@mail.gmail.com>
Message-ID: <20121101141935.GD4413@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2012 at 03:01:28PM +0100, Linus Walleij wrote:
> On Thu, Nov 1, 2012 at 1:07 PM, Mark Brown
> 
> > For the pin hogging I'd actually been thinking separately that we should
> > just have the device core do a devm_pinctrl_get_set_default() prior to
> > probing the device and store the result in the struct device.  That

> What if I retrieve this in the pinctrl subsystem using
> bus notifiers and then expose the struct pinctrl * to
> the clients by using pinctrl_get() and when you get
> such a handle in your probe() you know that the
> pinctrl subsystem has already fetched the handle and
> set it to "default" at that point?

I'm not sure I parse a problem from the above?

> I just worry whether there is a fringe case where the default
> state is not be be default-selected in probe(), the API
> semantics does not mandate that. But I think this is the case
> for all in-kernel drivers so we wouldn't be breaking anything
> by doing this right now. And platforms can just leave the
> "default" state undefined in that case.

Yes, that had been my thinking too though I'd really expect that the
platform ought to be able to think of something sensible to do by
default.

> Then what to do with sleep and idle is a question we need
> to handle next. Requiring PM domains for this is one
> approach, albeit a bit controversial.

Yup.  Notifiers are another option again I guess.  There's far fewer
drivers doing anything at all with that so it's a bit less urgent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121101/9d6217f3/attachment.sig>
