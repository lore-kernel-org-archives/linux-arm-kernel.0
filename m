From: broonie@kernel.org (Mark Brown)
Date: Sat, 28 Jun 2014 13:46:42 +0100
Subject: [alsa-devel] [PATCH 1/7] ASoC: fix debugfs directory creation bug
In-Reply-To: <53ACDAB7.5080703@metafoo.de>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
 <E1X0AZe-0003i7-0z@rmk-PC.arm.linux.org.uk>
 <53ACDAB7.5080703@metafoo.de>
Message-ID: <20140628124642.GR2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 04:45:11AM +0200, Lars-Peter Clausen wrote:
> On 06/26/2014 04:22 PM, Russell King wrote:
> >Avoid creating duplicate directories by prefixing codecs and platforms
> >with their separate identifiers.  This avoids snd-soc-dummy (which can
> >appear both as a dummy platform and a dummy codec on the same card)
> >from clashing.

> Do we actually want to create debugfs entries for the snd-soc-dummies? There
> shouldn't be any meaningful information in there.

On the one hand they're virtual things that we probably should be hiding
but then again part of what we're trying to do is stub things out as
they would be normally so special casing potentically causes problems.

> If we want to and if we change the naming scheme of the debugfs entries
> anyway we should also add the component name to the entry name. This fixes a
> issue with devices that register multiple components.

> The other thing is that we are working on generalizing the ASoC code and
> getting rid of the distinction between CODECs and platforms. Which means
> there won't really a way to get the prefix anymore soon.

Right, these are both issues.  However I think the patch is OK for now,
it does avoid an actual problem so I'll apply it for now - we can
further improve it later.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140628/e3a0cf44/attachment.sig>
