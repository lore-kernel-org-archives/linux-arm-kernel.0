From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Feb 2011 15:47:11 +0100
Subject: [PATCH] i.MX23/28 framebuffer driver
In-Reply-To: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <201102091547.12131.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 February 2011, Sascha Hauer wrote:
> Hi all,
> 
> The following patches add framebuffer support for Freescale i.MX23/28
> processors.

Hi Sascha,

The driver looks good as far as I can tell, but I'd recommend
submitting it to linux-fbdev at vger.kernel.org for review in
addition to linux-arm-kernel. The frame buffer layer is largely
unmaintained these days, but there are still people on that
list that care.

Did you consider making the driver a KMS driver instead of
a frame buffer? I think the recommendation these days is
to start out with KMS for new drivers, which will be somewhat
simpler and give you a frame buffer device as well. I don't
think that there is a need to change over any drivers from
fb to kms though, since you've already done the work.

	Arnd
