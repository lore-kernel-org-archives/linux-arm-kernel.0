From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Jul 2014 10:05:35 +0200
Subject: [RFC PATCH v3] reset: Add a defer reset object to send board
 specific reset
In-Reply-To: <CACRpkdYfu8HmVCkn9JFh+YP5OPdr8o9nTfoCnkJ7SSpGoenQUg@mail.gmail.com>
References: <1403098673-3058-1-git-send-email-houcheng@gmail.com>
 <CACRpkdYfu8HmVCkn9JFh+YP5OPdr8o9nTfoCnkJ7SSpGoenQUg@mail.gmail.com>
Message-ID: <20140708080535.GJ13423@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 09:52:03AM +0200, Linus Walleij wrote:
> On Wed, Jun 18, 2014 at 3:37 PM, Houcheng Lin <houcheng@gmail.com> wrote:
> 
> > The Problem
> > -----------
> > The reset signal on a hardware board is send either:
> >     - during machine initialization
> >     - during bus master's initialization
> 
> I just thought about this a bit, since there isn't already a generic GPIO
> reset driver, just call this drivers/reset/reset-gpio.c and make the
> ability to deferral just a configuration detail of the GPIO reset driver.

Philipp has been working on one for quite some time. See
http://www.spinics.net/lists/arm-kernel/msg321927.html

However, it seems to progress slowly, and we don't seem to be able to
reach a consensus here.

If you ask me, having to set a few extra properties like this just
advocates for a regular reset driver and DT node for the reset GPIO,
but I'm pretty sure Philipp will feel otherwise :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140708/0509ca19/attachment.sig>
