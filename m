From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 30 Dec 2015 19:37:19 +0100
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <20151230163307.GW16023@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
 <1451342963.14631.13.camel@collins> <5681D7A8.2030101@ti.com>
 <1451387613.18148.9.camel@collins> <568323B7.7080101@ti.com>
 <1451464521.2531.4.camel@collins> <20151230163307.GW16023@sirena.org.uk>
Message-ID: <1451500639.14341.6.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 30 d?cembre 2015 ? 16:33 +0000, Mark Brown a ?crit :
> On Wed, Dec 30, 2015 at 09:35:21AM +0100, Paul Kocialkowski wrote:
> 
> > In my opinion, it would be more elegant to adapt the core regulator
> > framework to first enable the GPIO and then call the regulator enable
> > ops callback instead of handling the GPIO in the driver.
> 
> Why would we want to actively manage both things at runtime?  It's more
> work, what do we gain from it?

Well, I figured that it would be best to disable the EN pin when we're
not using any of the regulators, since that allows the chip to enter
standby mode (and thus consume less power).

Implementing that logic in the driver seems very redundant when we're
one step away from doing it with the core regulator framework.
It is also likely that in the future, other chips will use and need to
handle a global enable pin for the same purpose, while allowing
regulator configuration and enable via registers.

It also doesn't hurt regulators that only use a GPIO for enable.

The diff to do this is very minimal, I already have a patch ready, that
I could send if there is a chance for it to get through.

-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151230/fc9c84aa/attachment.sig>
