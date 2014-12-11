From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Dec 2014 12:31:06 +0000
Subject: [PATCH 1/4] regulator: core: Support trying to get close to a
 certain voltage
In-Reply-To: <CAHNYxRy2t0OVj-+CqQFOfj0zWAGG0j8rmd8SxdNWgBMA2iAfXQ@mail.gmail.com>
References: <1418245085-9754-1-git-send-email-dianders@chromium.org>
 <20141210235347.GT11764@sirena.org.uk>
 <CAHNYxRy2t0OVj-+CqQFOfj0zWAGG0j8rmd8SxdNWgBMA2iAfXQ@mail.gmail.com>
Message-ID: <20141211123106.GU11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 05:08:37PM -0800, Alexandru Stan wrote:
> The spec is from 1.7V to 1.95V, with 1.8V being ideal. It's not that
> symmetric. But let's say that 0.1V is fine for tolerance(so 1.7-1.9V)

Don't top post so people reading your message have some context to give
them some idea what you are talking about.

> Imagine a board has a 1V-1.79 V regulator, we tell it to
> regulator_set_voltage_tol(1800000,100000). It will try the 1.8V-1.9V
> range, when it sees that it can't it'll fallback to 1.7V - 1.9V, and
> it will just be lazy and pick the lowest of the range again:
> 1.7V(causing voltage drop issues because we're exactly at the minimum
> of the spec). The correct voltage would be 1.79V

This is just an implementation detail, everything you're saying here
applies equally to any user specifying by tolerance rather than range.
If the reason for doing this is to fix that problem then a new API isn't
the way to go about it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141211/780202be/attachment.sig>
