From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 02 Jul 2012 11:35:04 -0600
Subject: Conflicts between Tegra PWM tree and common clock patches
Message-ID: <4FF1DBC8.2000406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry,

The following commits in your PWM tree conflict with some Tegra clock
driver re-structuring that's part of the common clock conversion on Tegra.

df6da47 ARM: tegra: Provide clock for only one PWM controller
65e7385 ARM: tegra: Fix PWM clock programming

To alleviate this, could we either:

a) Remove those two commits from your tree and into the Tegra tree. I
think this won't cause any runtime issues, since Tegra PWM is a feature
we aren't using yet, so it's OK if the branch it's made to work in is
not the PWM branch.

b) If your branch is stable, I can merge it into the Tegra tree in order
to resolve the conflicts there. However, for this to work, you need to
100% guarantee that the branch won't be rebased between now and when you
send Linus a pull request for 3.6.

Note that I'm out on Wednesday this week for 4th July holiday, and then
leaving on vacation for 2 weeks on July 8th, so we need to resolve this
quickly if we are to merge the Tegra common clock conversion before I
leave. Also, once we do (a) or (b) above, Prashant needs to rebase his
patches on the result, and he's in India, so there's a big time-zone
delay there too.

Sorry, when I ack'd the Tegra clock patches for the PWM tree, I don't
believe the common clock conversion was on the horizon.

Thanks!
