From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Feb 2014 14:13:58 +0000
Subject: [PATCH 05/17] mmc: mmci: Put the device into low power state at
 system suspend
In-Reply-To: <CACRpkdZt5+t7b0_a__2kJP4V9PS2cyXmguWrST+fzbKCnosi7g@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-6-git-send-email-ulf.hansson@linaro.org>
 <8738jyu1h9.fsf@paris.lan>
 <CACRpkdZt5+t7b0_a__2kJP4V9PS2cyXmguWrST+fzbKCnosi7g@mail.gmail.com>
Message-ID: <20140205141358.GJ22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 01:49:49PM +0100, Linus Walleij wrote:
> On Tue, Feb 4, 2014 at 8:22 PM, Kevin Hilman <khilman@linaro.org> wrote:

> > I'm trying to thing of a good reason to not make PM_SLEEP depend on
> > PM_RUNTIME for platforms like this.

> Isn't the typical Android platform using PM_SLEEP without using
> PM_RUNTIME?

No, not at all.  Android does make aggressive use of sleep but it's also
highly desirable to use runtime PM - for example you don't want to have
to power up the entire SoC simply because the system is getting a new
e-mail pushed to it or location updates, most of the hardware is doing
nothing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/9d95bf3e/attachment.sig>
