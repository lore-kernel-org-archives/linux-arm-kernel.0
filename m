From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Aug 2013 01:01:26 +0100
Subject: 32337ea "ASoC: warn if we will overwrite the DAI stream widgets"
In-Reply-To: <521E8798.10206@wwwdotorg.org>
References: <521E8798.10206@wwwdotorg.org>
Message-ID: <20130829000126.GQ6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 05:28:24PM -0600, Stephen Warren wrote:
> Russell, if the warning in commit 32337ea "ASoC: warn if we will
> overwrite the DAI stream widgets" fires, what do I need to do to the
> ASoC driver to fix it? (I'm deliberately ignoring any other issues with
> this patch, and looking only to discover what is apparently wrong with
> my driver that's triggering this...).
> 
> Steev Klimaszewski reported this warning to me, and I've repro'd it
> running next-20130827 on a couple of Tegra systems (TrimSlice and
> Seaboard at least), using sound/soc/tegra/tegra_{trimslice,wm8903}.c,
> and associated ASoC components.

I chucked this into linux-next in order to prove that the issue I had
been reporting was not specific to my systems here (because I was making
absolutely no useful progress with Mark.)  Mark finally admitted for the
first time that there's a bug here yesterday, so I've now dropped the
patch out of linux-next (either that's coincidental or cause and effect).
In any case, it's served its purpose.

As for how to solve the underlying problem, I have no idea - I've been
asking the same question of Mark for the last three weeks and just been
getting a load of drivel about "it's because you're using DPCM" and
other *totally useless* suggestions about the code I'm trying to get
working.

Liam says he's working on "a patch" last week, so I assume that this
issue will eventually be resolved.
