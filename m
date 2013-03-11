From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Mar 2013 11:10:11 +0000
Subject: [PATCH 06/10] ARM: soc-audio phycore-ac97: fix driver init order
In-Reply-To: <1362940391-8338-7-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-7-git-send-email-mpa@pengutronix.de>
Message-ID: <20130311111011.GA10617@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 10, 2013 at 07:33:07PM +0100, Markus Pargmann wrote:
> Adding a soc-audio sound driver internally uses snd_soc_register_device,
> which tries to bind it with the codec. The adding of the driver is
> deferred because the codec driver is not loaded.

> This patch changes the order of registration. The codec driver is there
> before the ac97 driver, so the snd_soc_register_device call is
> successfull.

You shouldn't be using soc-audio in the first place...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130311/e16ef4a2/attachment.sig>
