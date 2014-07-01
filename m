From: broonie@kernel.org (Mark Brown)
Date: Tue, 1 Jul 2014 13:11:42 +0100
Subject: [PATCH] regulator: core: Still free GPIOs using gpio_free()
In-Reply-To: <20140701120622.GJ32514@n2100.arm.linux.org.uk>
References: <1404215726-2480-1-git-send-email-broonie@kernel.org>
 <20140701120622.GJ32514@n2100.arm.linux.org.uk>
Message-ID: <20140701121142.GM23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 01:06:22PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 01, 2014 at 12:55:26PM +0100, Mark Brown wrote:

> > Even though we mostly use GPIO descriptors internally we still use
> > gpio_request_one() to request so we need to pair that with gpio_free() to
> > release the GPIO.

> This doesn't explain the reason...  I see the current GPIO code doing this:

> void gpio_free(unsigned gpio)
> {
>         gpiod_free(gpio_to_desc(gpio));
> }
> EXPORT_SYMBOL_GPL(gpio_free);

Huh, good point (though it still seems a bit neater to match up the
request and release functions I guess).  Linus?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140701/833c328d/attachment.sig>
