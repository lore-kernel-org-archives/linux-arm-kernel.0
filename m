From: koro.chen@mediatek.com (Koro Chen)
Date: Thu, 15 Oct 2015 20:49:40 +0800
Subject: [alsa-devel] [RFC PATCH] ASoC: Modify check condition of
 multiple bindings of components
In-Reply-To: <20151015121035.GE14956@sirena.org.uk>
References: <1444743477-48819-1-git-send-email-koro.chen@mediatek.com>
 <561D0AA9.5080702@metafoo.de> <1444745902.26493.2.camel@mtksdaap41>
 <561D1843.1020007@metafoo.de> <1444785549.26493.12.camel@mtksdaap41>
 <561E1991.1050705@metafoo.de> <20151015121035.GE14956@sirena.org.uk>
Message-ID: <1444913380.26493.38.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-10-15 at 13:10 +0100, Mark Brown wrote:
> On Wed, Oct 14, 2015 at 11:00:01AM +0200, Lars-Peter Clausen wrote:
> 
> > It was never intended that it is possible to bind a component to multiple
> > cards. That it was possible was a bug that was overlooked and some people
> > tried to do it which caused apparently random crashes later on, caused by
> > the data structure corruption. This is why we added the check to catch this
> > kind of mistake early and to avoid the crashes.
> 
> This is true, but I do think it's something that we should have some
> story on supporting for some of this hardware that has a bunch of
> channels in one IP block that can't really interact with each other.
> It's going to make it a lot easier for people to think about the
> hardware and how to describe it.
Yes, and if in some cases we must use multiple cards, it seems the only
option left is to separate an ASoC platform driver into multiple
drivers. It does not make sense to me since there is only one HW block.
