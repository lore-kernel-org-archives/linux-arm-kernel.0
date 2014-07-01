From: broonie@kernel.org (Mark Brown)
Date: Tue, 1 Jul 2014 13:27:17 +0100
Subject: [PATCH] regulator: core: Still free GPIOs using gpio_free()
In-Reply-To: <CAAVeFuJqRW0ih8Mg9MFwLf=wQ7eVK5+pm8deW0vTUdozJ16FfQ@mail.gmail.com>
References: <1404215726-2480-1-git-send-email-broonie@kernel.org>
 <20140701120622.GJ32514@n2100.arm.linux.org.uk>
 <20140701121142.GM23300@sirena.org.uk>
 <CAAVeFuJqRW0ih8Mg9MFwLf=wQ7eVK5+pm8deW0vTUdozJ16FfQ@mail.gmail.com>
Message-ID: <20140701122717.GN23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 09:24:22PM +0900, Alexandre Courbot wrote:
> On Tue, Jul 1, 2014 at 9:11 PM, Mark Brown <broonie@kernel.org> wrote:

> > Huh, good point (though it still seems a bit neater to match up the
> > request and release functions I guess).  Linus?

> Yeah it's a nice habit to free the GPIOs using the same interface as
> the one used to obtain them. Although if we are to allow the regulator
> framework to request GPIO through both the integer and descriptor
> interfaces, we certainly don't want to track that information forever.

> On top of that we want to limit the use of gpio_to_desc() and
> desc_to_gpio() in drivers as much as possible, so I'd say I prefer to
> see gpiod_free() used no matter where the GPIO came from.

Right, but Linus said we didn't need this conversion to descriptors so
I'm a bit confused as to what the issue he was raising was.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140701/cf003a82/attachment.sig>
