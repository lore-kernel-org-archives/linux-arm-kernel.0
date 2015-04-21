From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Apr 2015 11:14:16 +0100
Subject: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
In-Reply-To: <20150421094926.GU6325@pengutronix.de>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
 <20150418173407.GE26185@sirena.org.uk>
 <20150420043747.GH6325@pengutronix.de>
 <20150420204849.GJ14892@sirena.org.uk>
 <20150421094926.GU6325@pengutronix.de>
Message-ID: <20150421101416.GC22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 11:49:26AM +0200, Sascha Hauer wrote:

> I think this could be done. I checked the possible connections in the
> crossbar switch and it seems all memory interfaces can be connected with
> all relevant external interfaces. So indeed the memory interfaces could
> be dynamically allocated instead of statically associated to an
> external interface. There are two problems I see: Some memory interfaces
> are limited in the rates they support, they can only do 8k/16k/32k (for
> speech). How can we know such memory interface should be used? Also
> there are two programmable hardware gain blocks which can be inserted to
> the digital audio path using the crossbar switch. There must be some
> mechanism to configure them into different places.

This (particularly the gain controls) sounds like you want to expose the
routing to userspace and use DPCM, the code also seemed to look like it
was a good fit for DPCM.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150421/e006ea93/attachment.sig>
