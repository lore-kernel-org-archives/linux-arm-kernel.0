From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 17:18:39 +0100
Subject: [PATCH RFC 03/13] ASoC: avoid duplicated DAI routes
In-Reply-To: <E1V63uN-0004lL-7q@rmk-PC.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63uN-0004lL-7q@rmk-PC.arm.linux.org.uk>
Message-ID: <20130805161839.GQ9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 08:24:03PM +0100, Russell King wrote:
> ASoC automatically creates snd_soc_dapm_dai_in and snd_soc_dapm_dai_out
> widgets for DAI drivers, and adds them to the list.  Later on, ASoC
> creates automatic routes between these widgets and a widget with a
> stream name.

Applied, thanks.  It's possible to do this a bit more neatly for example
by checking the direction of the link but this works and fixes the
problem, we can always improve it further later.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/905173c4/attachment.sig>
