From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Jul 2013 09:39:17 +0200
Subject: [PATCH] gpio/mxc: add chained_irq_enter/exit() to
 mx2_gpio_irq_handler
In-Reply-To: <CACRpkdZjsAOtm2Jt7kY-VC2ToFfMQ+UxjWQE7aUZAbsBt0ugvw@mail.gmail.com>
References: <1374152286-12955-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdZjsAOtm2Jt7kY-VC2ToFfMQ+UxjWQE7aUZAbsBt0ugvw@mail.gmail.com>
Message-ID: <20130730073917.GL1754@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Jul 29, 2013 at 05:51:17PM +0200, Linus Walleij wrote:
> On Thu, Jul 18, 2013 at 2:58 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Similar to commit
> >
> >         0e44b6e (gpio/mxc: add chained_irq_enter/exit() to mx3_gpio_irq_handler())
> >
> > . It doesn't seem to be critical to make the irqs work, but still it is
> > more correct.
> >
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Patch is fine, but looks like this to me:
> 
> Content-Transfer-Encoding: base64
> 
> Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
> Errors-To: linux-arm-kernel-bounces+linus.walleij=linaro.org at lists.infradead.org
> 
> U2ltaWxhciB0byBjb21taXQKCgkwZTQ0YjZlIChncGlvL214YzogYWRkIGNoYWluZWRfaXJxX2Vu
> dGVyL2V4aXQoKSB0byBteDNfZ3Bpb19pcnFfaGFuZGxlcigpKQoKLiBJdCBkb2Vzbid0IHNlZW0g
> dG8gYmUgY3JpdGljYWwgdG8gbWFrZSB0aGUgaXJxcyB3b3JrLCBidXQgc3RpbGwgaXQgaXMKbW9y
> ZSBjb3JyZWN0LgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtv
> ZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCkhlbGxvLAoKbm90ZSB0aGlzIGlzIGNvbXBsZXRlbHkg
> dW50ZXN0ZWQuCgpVd2UKCiBkcml2ZXJzL2dwaW8vZ3Bpby1teGMuYyB8IDQgKysrKwogMSBmaWxl
> 
> The encoding is what screw things up.
That means git is unable to apply base64 encoded mail? Hmm, testing with
git 1.8.3.2 (from Debian) I can apply the base64 encoded patch.
Does your git have 87ab799234639c26ea10de74782fa511cb3ca606 (i.e. is
older than 1.5.1)?

> Can you see if you can resend this without using base64?
The version I got back via the kernel at pengutronix.de address has:

	Content-Type: text/plain; charset=UTF-8
	Content-Transfer-Encoding: 8bit

and the content is readable just fine in an editor. My copy I got via
the linux-arm-kernel subscription is base64 encoded, too. So a mail
server on the way to you reencodes my mail. At gmane
(http://article.gmane.org/gmane.linux.ports.arm.kernel/252948/raw) it's
already base64. According to the Received: headers it can only be
casper.infradead.org or merlin.infradead.org.

I found

	http://mail.python.org/pipermail/mailman-users/2008-September/063286.html

which is really annoying. I'll bounce you the original.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
