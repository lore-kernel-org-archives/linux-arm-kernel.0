From: broonie@kernel.org (Mark Brown)
Date: Sun, 8 Dec 2013 19:40:40 +0000
Subject: [RFC part1 PATCH 0/7] Make ACPI core running on ARM64
In-Reply-To: <201312080344.56317.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312052325.02603.arnd@arndb.de>
 <20131206135825.GG29268@sirena.org.uk>
 <201312080344.56317.arnd@arndb.de>
Message-ID: <20131208194040.GN29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 08, 2013 at 03:44:56AM +0100, Arnd Bergmann wrote:
> On Friday 06 December 2013, Mark Brown wrote:

> > OTOH if it's well encapsulated, is going to be required for any kind of
> > ACPI use and gets to the point where people are OK with it by itself
> > then I'm not sure what we'd gain by keeping it out of tree - it'd make
> > the real system patch sets bigger and harder to review.

> I'd agree as soon as someone can convince me that we actually want ACPI
> support in the kernel for ARM64 servers. As far as I'm concerned it's quite
> possible that the people who have worked on this for the past couple of
> years behind closed doors know what they are doing and it will all be
> good, but it's also possible that it turns into a huge trainwreck once
> we see multiple implementations that have fundamentally incompatible
> requirements regarding what they want from ACPI and we end up not doing
> it at all. I just don't have enough information at this point to know which
> of the two is true and I'd like to ensure that accepting the patches
> that meet your criteria above would not be seen as an endorsement to do
> crazy stuff later.

I do share all your concerns about the closed door stuff, and I'm also
not convinced that they'll be able to control the things people try to
do with it if it does become at all successful.  

That said I don't think anyone could be in any reasonable doubt as to
the concerns that people have at this point and I do worry that keeping
everything out of tree will both increase reviwer fatigue if it does end
up getting merged and increase the chances that we end up with a
deployed fiat accomplait being submitted.  We can always add dire
warnings and so on to the code and Kconfig to try to remind people but
so long as it's neither getting in the way of anything else nor making
any real decisions (as opposed to basics for the core spec) I'm not sure
how much we gain, if it never goes anywhere it can just sit and rot
quietly in a corner until it gets in the way.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131208/81755432/attachment-0001.sig>
