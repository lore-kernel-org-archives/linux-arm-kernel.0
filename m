From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Oct 2015 13:10:35 +0100
Subject: [alsa-devel] [RFC PATCH] ASoC: Modify check condition of
 multiple bindings of components
In-Reply-To: <561E1991.1050705@metafoo.de>
References: <1444743477-48819-1-git-send-email-koro.chen@mediatek.com>
 <561D0AA9.5080702@metafoo.de> <1444745902.26493.2.camel@mtksdaap41>
 <561D1843.1020007@metafoo.de>
 <1444785549.26493.12.camel@mtksdaap41>
 <561E1991.1050705@metafoo.de>
Message-ID: <20151015121035.GE14956@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 11:00:01AM +0200, Lars-Peter Clausen wrote:

> It was never intended that it is possible to bind a component to multiple
> cards. That it was possible was a bug that was overlooked and some people
> tried to do it which caused apparently random crashes later on, caused by
> the data structure corruption. This is why we added the check to catch this
> kind of mistake early and to avoid the crashes.

This is true, but I do think it's something that we should have some
story on supporting for some of this hardware that has a bunch of
channels in one IP block that can't really interact with each other.
It's going to make it a lot easier for people to think about the
hardware and how to describe it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/3814f238/attachment.sig>
