From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 Nov 2011 12:27:34 +0100
Subject: [PATCH 2/5] dma i.MX: remove individual SOC dependency
In-Reply-To: <CAHXqBFKps1jsaKCr9yqQY72zAQHT6HU78eJ+adbYfnhRhkKQog@mail.gmail.com>
References: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
 <1314168072-13822-3-git-send-email-s.hauer@pengutronix.de>
 <CAHXqBFKps1jsaKCr9yqQY72zAQHT6HU78eJ+adbYfnhRhkKQog@mail.gmail.com>
Message-ID: <20111109112734.GI16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 09:42:56PM +0100, Micha? Miros?aw wrote:
> 2011/8/24 Sascha Hauer <s.hauer@pengutronix.de>:
> > The individual SoC dependency in Kconfig hardly scales anymore.
> > Instead of having such a fine grained dependency just depend
> > on ARCH_MXC and risk that the uninformed user has to look in
> > the help text to figure out which driver is the correct one.
> [...]
> > ?config MX3_IPU
> > ? ? ? ?bool "MX3x Image Processing Unit support"
> > - ? ? ? depends on ARCH_MX3
> > + ? ? ? depends on ARCH_MXC
> > ? ? ? ?select DMA_ENGINE
> > ? ? ? ?default y
> > ? ? ? ?help
> 
> You could instead make it depend on HAVE_MX3_IPU and select this
> symbol from relevant model config. Leaving it for the users is making
> every one of them redo the work you already did.

I thought about this. I came to the conclusion that these are quite hard
to change when they are present in many subsystems (I try to get rid of
ARCH_MXx macros for some time now). Also with upcoming devicetree
support the IMX_HAVE_ macros will loose their meaning anyway. Being a
bit more relaxed with the 'depends on' only means that a user might
compile in some unused drivers, which is the standard case on other
architectures like x86 anyway.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
