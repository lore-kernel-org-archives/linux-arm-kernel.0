From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 Jan 2014 12:38:19 +0000
Subject: [PATCH RFC 4/6] net: rfkill: gpio: add device tree support
In-Reply-To: <201401211950.07011.arnd@arndb.de>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
 <201401211335.16885.arnd@arndb.de>
 <CAAVeFuKFfAvSPYLmvWV5jjT-peZFJ8sJ2bbh4F=JAYoWLhjZpA@mail.gmail.com>
 <201401211950.07011.arnd@arndb.de>
Message-ID: <20140122123819.GH17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 07:50:06PM +0100, Arnd Bergmann wrote:

> I should have another look at the debugfs representation, but isn't
> there a global namespace that gets used for all gpios?  Neither the
> con_id nor the name that the driver picks would be globally unique
> and stable across kernel versions, so they don't make a good user
> interface.

Currently the globally unique name is the GPIO number but that's not
stable since it gets dynamically assigned.  

> I think what we want here is a system-wide unique identifier for
> each gpio line that may get represented in debugfs, and use a new
> DT mechanism to communicate that.

We've mostly been using things based off dev_name() for stability.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140122/dfe74bd2/attachment.sig>
