From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 17 Sep 2013 22:48:48 -0500
Subject: [PATCH v7 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <CACxGe6s_JY7GpjXN7gwADV0oE+BnQfJX4AaXTZURumfepa3NiA@mail.gmail.com>
References: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
 <1377527959-5080-4-git-send-email-m.szyprowski@samsung.com>
 <20130829224637.D09183E1222@localhost> <52209278.8040106@samsung.com>
 <DAF223EB-C84C-4E82-A24A-ACD0A3A0559F@codeaurora.org>
 <20130909160154.8D7183E0F23@localhost> <5236AF64.80607@samsung.com>
 <1379316344.3721.6.camel@pasglop>
 <CACxGe6s_JY7GpjXN7gwADV0oE+BnQfJX4AaXTZURumfepa3NiA@mail.gmail.com>
Message-ID: <20130918034848.A8E76C42CF4@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Sep 2013 06:43:08 -0700, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Sep 16, 2013 at 12:25 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Mon, 2013-09-16 at 09:12 +0200, Marek Szyprowski wrote:
> >>
> >> Fixing those issues requires further discussion. Frankly, right now I
> >> really have no idea which way should I go. The /reserved-ranges node seems
> >> to be easy to match particular reserved memory region with a given device.
> >> I'm also not really convinced if it makes sense to add a code for finding
> >> and matching a reserved memory region to every device driver, which might
> >> need it. I would really like to get some more feedback on the Ben's
> >> comment.
> >>
> >> In any case, the code will also change significantly, so I assume that the
> >> best, what can be done now is to revert the current version and start from
> >> the scratch with a new, complete proposal.
> >
> > Yes, let's do that. I will try to help. It shouldn't be that a big deal.
> 
> I think we can get the concerns sorted quickly. I'm at meetings all
> day today in SJC, but I'll take a look at it this evening. I'll be in
> Edinburgh. We're holding an ARM summit at the same time so a bunch of
> affected ARM folks will be there.

After reading through the entirety of the other thread, I think this can
be fixed. My preference would be to fix in now rather than waiting
another cycle. If you haven't sent the revert yet then please hold off
for a bit (I can't tell at the moment since I'm currently on an airplane
and I didn't update my tree before leaving the ground).

g.
