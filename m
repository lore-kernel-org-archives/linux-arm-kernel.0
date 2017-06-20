From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 Jun 2017 15:33:52 +0100
Subject: [PATCH 1/2] ASoC: add bindings for ZTE zx-aud96p22 audio codec
In-Reply-To: <20170620031131.GB4818@x250>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-2-git-send-email-shawnguo@kernel.org>
 <20170619161606.g6nabi2w5mmmjbcw@sirena.org.uk>
 <20170620031131.GB4818@x250>
Message-ID: <20170620143352.rjitvgkzh554pviq@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 11:11:32AM +0800, Shawn Guo wrote:
> On Mon, Jun 19, 2017 at 05:16:06PM +0100, Mark Brown wrote:

> > If there's an external power amplifier this is a separate chip to this
> > CODEC and should therefore be separately controlled and integrated as
> > part of the machine integration.

> Yes, that should be the best.  But we do not have a particular machine
> driver for our platform, and we are using simple-audio-card driver

You should be switching to the of-graph card now.

> instead.  I'm not sure if it's generic enough to patch simple-audio-card
> driver support this pa-gpios, so chose to fold this quick change in the
> codec driver.

Having a separate amplifier is a completely normal thing, and no matter
how unusual something is it's obviously not OK to hack one driver to
support a completely different device.

> Should I patch simple-audio-card driver to support pa-gpios property
> and create a DAPM widget with event for it?  I'm currently using
> SND_SOC_DAPM_OUT_DRV_E.  Is it the correct one?

Should be fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/75386a12/attachment.sig>
