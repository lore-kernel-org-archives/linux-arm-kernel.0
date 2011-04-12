From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Apr 2011 09:52:37 +0100
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <BANLkTim6N8OAY6dwdOfrCmLwPe=EuUGrAg@mail.gmail.com>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
	<20110411074041.GF18601@pengutronix.de>
	<alpine.LFD.2.00.1104110944290.28032@xanadu.home>
	<BANLkTim6N8OAY6dwdOfrCmLwPe=EuUGrAg@mail.gmail.com>
Message-ID: <20110412085237.GA30550@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do _not_ top post.

On Mon, Apr 11, 2011 at 04:50:48PM -0500, Matt Sealey wrote:
> Well, whoever's responsibility it is to fix this, whereever it needs
> to be fixed, it needs to be fixed, as it is absolutely nuts that you
> cannot run an MX51 and MX53 board off the same kernel.
> 
> If nobody knows or agrees, can anyone can identify exactly what needs
> to be fixed and where, and how much work this would actually be, so
> they or someone else can actually go do it, instead of us just
> debating about how experimental it might be?
> 
> As far as I see it the only reason it depends on EXPERIMENTAL is
> because it breaks at least one subarch, it breaks XIP kernels and it
> breaks Thumb2 kernels (this last one is not so much a showstopper for
> enabling it by default, unless I am mistaken in my assumption that
> Thumb2 kernels still don't work reliably right now anyway?)

I can only guess that you're talking about the dynamic patching of the
virt_to_phys stuff - but that's only a guess because there is _no_
_context_ because you _top_ _posted_.

It is marked as EXPERIMENTAL because it is a new feature which has just
gone in, and hasn't had sufficient testing out in the wild to justify
removal of EXPERIMENTAL.  Therefore, the EXPERIMENTAL tag tells people
that the feature may not be as stable as it should be.

It can be removed _after_ the next merge window when we have a higher
confidence that no one has seen any major problems with it.
