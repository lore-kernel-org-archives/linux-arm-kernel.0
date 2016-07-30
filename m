From: broonie@kernel.org (Mark Brown)
Date: Sat, 30 Jul 2016 02:05:36 +0100
Subject: [PATCH] arm64: dts: rockchip: add spiX aliases for rk3399
In-Reply-To: <20160729233950.GA102046@google.com>
References: <1468545873-134339-1-git-send-email-briannorris@chromium.org>
 <20160719192912.GA142821@google.com> <1841177.NDa9D09EGz@diego>
 <3484113.eKHnDqRbfE@diego> <20160729233950.GA102046@google.com>
Message-ID: <20160730010535.GO10376@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2016 at 04:39:51PM -0700, Brian Norris wrote:

> + Mark

I very nearly deleted this unread based on the subject line...

> I had read that already. I figured that was just rationale for not
> documenting the feature (still silly IMO), and not for avoiding using
> the existing feature.

All in tree aliases provided for SPI buses are strings so if we're doing
anything with aliases we really ought to be parsing them as strings not
numbers (they're people describing the use of buses on their board).  

I quite seriously am more inclined to remove the numbering functionality
as stands than document it as stands given how many layers of
implementation specifics are required to make practical use of it and
the existing practical use for human readable purposes, all we're doing
is trying to be helpful with some random string we found somewhere and
we don't want to encourage people to do that rather than doing what
they're currently doing any providing human readable names.  We
shouldn't preclude being more helpful if we get better ideas and we
shouldn't encourage people to make bad decisions about identifying
things from userspace.  Or I suppose we could go the way of all
standards and document useful behaviour without implementing it but that
doesn't seem awesome either.

> What is this "label" feature Rob speaks of? Does it exist in practice
> (AFAICT the answer is "no")? The description doesn't seem terrible,

It's a property called "label" which is a standard thing in DT for
providing descriptive labels, if you look in git you can see quite a few
examples for other subsystems.  I'd expect to see it show up in the
string for the device name in place of the numbers (both if used for a
device, the bus number for the bus).  Nobody has written any code yet,
I've never personally found the motivation and nobody sent me any
patches.

> depending on the implementation. Would that become the actual device
> name (i.e., dev_name(dev))? Or just a filesystem symlink? And how does
> one assign such a label?

It should really show up in dev_name() since for most devices it'll be
more likely to show up in a log message than anywhere else.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160730/9c5babf6/attachment.sig>
