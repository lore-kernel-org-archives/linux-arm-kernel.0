From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Apr 2017 21:19:50 +0100
Subject: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
In-Reply-To: <CAL_Jsq+bsh8Byow4poT7cdpLY_skb7QxbzkAmj4q7Cf6Z88GWA@mail.gmail.com>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <CAL_Jsq+bsh8Byow4poT7cdpLY_skb7QxbzkAmj4q7Cf6Z88GWA@mail.gmail.com>
Message-ID: <20170411201950.37ef4qpiefhengjn@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 11:02:57AM -0500, Rob Herring wrote:
> On Tue, Apr 11, 2017 at 9:32 AM, Mark Brown <broonie@kernel.org> wrote:

> > The graph card is blocked on your review...

> Maybe if there were more reviewers it would move faster. I don't know
> ASoC that well.

The times I've looked at it recently it's been stuck in DT style issues
rather than anything substantially ASoC related, as far as I can tell
the binding is essentially empty from an ASoC point of view and
inherited from the of_graph binding.  There's bits in that are a bit
random like specifically listing the CPU DAIs and only them but that
just looks like one of these random DT things that's predetermined.  I
really can't see anything at all in there to review from an ASoC point
of view, I've applied the changes that don't seem blocked on the
binding.  If there's something you're looking for then please say...

We never seem to make any progress on the generic changes in drivers/of at
the start of the series either...

> > I'm also not clear how
> > without something like this we'd be able to identify a specific DAI
> > within a device if we don't have a way of identifying them.

> Isn't that what the graph does? "dais" points to a list of ports which
> are the specific DAIs whether there are multiple ones in a single
> device or multiple devices with a single DAI each.

But the ports can still have indexes AFAICT (the examples show port at 0,
port at 1 and so on) so we still need to define what those indexes mean
which is what this is doing?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170411/43cb8efb/attachment-0001.sig>
