From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 10 Sep 2014 16:08:48 +0200
Subject: [Patch v2 RfT] ARM: Kirkwood: Fix DT based DSA.
In-Reply-To: <20140909171742.GT30828@titan.lakedaemon.net>
References: <1409592941-22244-1-git-send-email-andrew@lunn.ch>
 <20140909160635.GR30828@titan.lakedaemon.net>
 <cbad0fa9a53346c4a67863ce924189a4@IL-EXCH02.marvell.com>
 <20140909171742.GT30828@titan.lakedaemon.net>
Message-ID: <20140910140848.GC13342@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 01:17:42PM -0400, Jason Cooper wrote:
> > I've tested v2 of the patch and it worked fine.

Hi Eugene, thanks for testing.
> 
> Ok, I'll consider that a Tested-by...
> 
> > Though, I had a couple of comments:
> > 
> > 1) I have concerns regarding naming of the boards.
> > Since distros use those names to identify boards, we should use
> > shorter and consistent naming.

I agree with Jason here. The filenames don't matter, its the
description in the compatible string which people should be looking
at. And it seems Marvell own naming of these boards is not
particularly good either.

> > other too).  With 3.17rc2 I am not able to get more then ~50Mbps while
> > same board with in same setup running v3.2 or v3.10 easily pass
> > 650Mbps mark.
> 
> Is this with/without this particular patch?  Or is this a separate
> issue?

I've not looked at this yet, but i guess it is related to TSO and the
stack trace we are seeing. It is independent of this patch. Without
this patch, networking is totally borked. With this patch, it somewhat
works, but i guess with packet loss, causing the low TCP bandwidth.

Once i'm back home i will take a look at this.

> Yes, which will be near the end of the window for getting this in.  I'd
> like to have everything hammered out _before_ he returns so he can Ack a
> (potentially) new version that I can apply.

If Eugene wants to produce a version with slightly modified model and
compatible strings, i can Ack it during the next couple of days. I
should have internet access. If not, please take the patch as is, with
the Tested-by added.

    Thanks
	Andrew
