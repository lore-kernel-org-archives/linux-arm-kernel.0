From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 15 Oct 2015 11:04:28 -0600
Subject: [PATCH] mtd: document linux-specific partition parser DT binding
In-Reply-To: <20151015162210.GA4545@localhost>
References: <1444915191-28350-1-git-send-email-linus.walleij@linaro.org>
 <20151015162210.GA4545@localhost>
Message-ID: <20151015170428.GA9250@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 09:22:10AM -0700, Brian Norris wrote:

> Are you trying to use this binding, or is this just purely a mechanical
> documentation issue? I ask, because it seems that binding never really
> got reviewed at all, and others have recently tried to extend
> support

I wrote it before ARM started down the DT direction and all these
formalities were developed.

> That's not to say we can't document the old one, but I'm curious if
> there are real users. I'd also like to encourage new users to avoid the
> old one if we can make that feasible.

We continue to use it here, there is just no way to autodetect flash
partition layouts. I'm not fussed about having to change to something
else in future.

The reason the original patch exposed the cmdline parser is because
that is how the internal mechanisms work - but realistically, the
cmdline parser is a hack to get around the lack of DT partition
description. If the DT can describe the partitions it should supersede
and obsolete the old command line hack. IMHO

> Also, if we're really going to support this, we should list exactly what
> strings we support. And that's one of the problems with the existing
> binding; it supports any old string Linux supports, which doesn't match
> how we typically want to add bindings (i.e., via proposal + review).

That is why it is prefixed with linux, the review of the part parser name is
the responsibility of the MTD crew, not the DT folks.

bcm47xxpart seems like a terrible name for a partition scheme. Really,
almost any scheme can be used on any SOC, naming a partition parser
after a SOC family makes very little sense to me..

Jason
