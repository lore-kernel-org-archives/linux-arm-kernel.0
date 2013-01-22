From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 22 Jan 2013 18:19:25 +0900
Subject: [GIT PULL] Renesas ARM-based SoC v3.9
In-Reply-To: <20130122082123.GA28100@quad.lixom.net>
References: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
 <20130116063750.GA11765@verge.net.au>
 <20130116234310.GA411@quad.lixom.net> <2682612.QaV0caZ3tv@avalon>
 <20130122082123.GA28100@quad.lixom.net>
Message-ID: <20130122091924.GB11708@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 12:21:23AM -0800, Olof Johansson wrote:
> On Mon, Jan 21, 2013 at 04:31:43PM +0100, Laurent Pinchart wrote:
> > Sure, we could push 1-6 through the ARM tree, wait until it reaches mainline, 
> > then push 7 through the pinctrl tree, wait until it reaches mainline, push 8 
> > through the SH tree and 9 through the ARM tree, wait until they reach 
> > mainline, and finally push 10 through the pinctrl tree again. We could even 
> > push each branch through the tree it belongs to, but I doubt we'll be able to 
> > push everything during a single merge window.
> 
> Ah, ok -- you're suggesting bringing it _all_ in through arm-soc. We
> can do so, I was of the initial impression from Simon's cover letter
> that the arch/sh branches would also go through the SH tree.
> 
> This seems to be a particularly hairy conversion, given that it touches two
> architectures that need to be updated in lockstep. I guess we might be just as
> well off pulling it in as-is (with below exceptions) to get it in.
> 
> If you need the same contents in the SH tree due to dependencies and
> later development, let me know and we can agree on a stable branch that
> we both pick up in either tree that has all contents.
> 
There isn't anything at the moment pending for the SH tree that cares
about or conflicts with any of this work, so it's ok with me if this all
goes through arm-soc. If there is any fallout we can take care of it
later on in the merge window. This would seem to be a saner option than
attempting to merge half a dozen branches with dependencies on each other
in precise order, which doesn't leave a lot of time for fixing up
any residual merge window damage.
