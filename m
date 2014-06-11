From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Jun 2014 19:27:13 +0100
Subject: [PATCH 1/2 v3] spi: s3c64xx: use "cs-gpios" from spi node
 instead of "cs-gpio"
In-Reply-To: <CAHfPSqB3V+vBCj03WLkeLQ5e7O4r+pUKQ-yZpK=tdAqVV1GuLw@mail.gmail.com>
References: <1402468318-7342-1-git-send-email-ch.naveen@samsung.com>
 <539839D6.1050305@collabora.co.uk>
 <CAHfPSqCYqTRBBH56y81na-t18pvoPmyWobZwXNgkrtq=H_79CQ@mail.gmail.com>
 <5398918F.4060800@collabora.co.uk> <539896FB.4050702@gmail.com>
 <CAHfPSqB3V+vBCj03WLkeLQ5e7O4r+pUKQ-yZpK=tdAqVV1GuLw@mail.gmail.com>
Message-ID: <20140611182713.GM5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 11:53:30PM +0530, Naveen Krishna Ch wrote:
> On 11 June 2014 23:20, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> > - in DT case, don't do anything in the driver about the GPIO chip
> > select, because it will be handled automatically by the core.

> But, i see that gpio_request_one is needed in _setup function in the driver.
> Except that no other gpio related operation is needed in the driver.

Ideally this code could be moved into the core too - indeed, ideally the
non-DT case could be handled by the core too except for the bit where we
look up what GPIO to use.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140611/22e2901e/attachment.sig>
