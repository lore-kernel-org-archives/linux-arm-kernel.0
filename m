From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 2 Jul 2012 21:24:54 +0200
Subject: Conflicts between Tegra PWM tree and common clock patches
In-Reply-To: <4FF1DBC8.2000406@wwwdotorg.org>
References: <4FF1DBC8.2000406@wwwdotorg.org>
Message-ID: <20120702192454.GA1299@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 11:35:04AM -0600, Stephen Warren wrote:
> Thierry,
> 
> The following commits in your PWM tree conflict with some Tegra clock
> driver re-structuring that's part of the common clock conversion on Tegra.
> 
> df6da47 ARM: tegra: Provide clock for only one PWM controller
> 65e7385 ARM: tegra: Fix PWM clock programming
> 
> To alleviate this, could we either:
> 
> a) Remove those two commits from your tree and into the Tegra tree. I
> think this won't cause any runtime issues, since Tegra PWM is a feature
> we aren't using yet, so it's OK if the branch it's made to work in is
> not the PWM branch.
> 
> b) If your branch is stable, I can merge it into the Tegra tree in order
> to resolve the conflicts there. However, for this to work, you need to
> 100% guarantee that the branch won't be rebased between now and when you
> send Linus a pull request for 3.6.

I'd very much prefer a). Both patches touch only Tegra code anyway so
there's no harm to take them through the Tegra tree. Both patches are
also not dependent on the PWM framework in any way.

> Note that I'm out on Wednesday this week for 4th July holiday, and then
> leaving on vacation for 2 weeks on July 8th, so we need to resolve this
> quickly if we are to merge the Tegra common clock conversion before I
> leave. Also, once we do (a) or (b) above, Prashant needs to rebase his
> patches on the result, and he's in India, so there's a big time-zone
> delay there too.
> 
> Sorry, when I ack'd the Tegra clock patches for the PWM tree, I don't
> believe the common clock conversion was on the horizon.

Nowhere near the horizon. =) Anyway I think a) above should be the
easiest and fastest so we should be able to get it resolved before
Wednesday. I can drop them from the PWM tree right away.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/02844aab/attachment-0001.sig>
