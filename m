From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 17 Jul 2012 10:41:04 +0800
Subject: [PATCH 1/2] pinctrl: pinctrl-imx: add support for set bits for
 general purpose registers
In-Reply-To: <CACRpkdbKOQt=gqydQNRfCOU-TaschHtFq0e_86xgvtHYMnwpKA@mail.gmail.com>
References: <1341565763-10074-1-git-send-email-b29396@freescale.com>
 <CACRpkdbKOQt=gqydQNRfCOU-TaschHtFq0e_86xgvtHYMnwpKA@mail.gmail.com>
Message-ID: <20120717024104.GE19699@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2012 at 04:24:16AM +0800, Linus Walleij wrote:
> On Fri, Jul 6, 2012 at 11:09 AM, Dong Aisheng <b29396@freescale.com> wrote:
> 
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> >
> > The General Purpose Registers (GPR) is used to select operating modes for
> > general features in the SoC, usually not related to the IOMUX itself,
> > but it does belong to IOMUX controller.
> > We simply provide an convient API for driver to call to set the general purpose
> > register bits if needed.
> >
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> 
> I have an overall objection to this:
> 
> I have no idea at all about what's going on, and why this belongs in the pin
> control subsystem. On the contrary, from the commit description it seems to
> *not* belong in this subsystem at all.
> 
Yes, it's just from hw point of view, these GPR registers are included in IOMUXC
block. But as the spec says in my commit messages, most of what they do are not
related to IOMUX itself.
So i would agree it doesn't belong to pinctrl subsystem if we can find a better
place.

> So: exactly what does this register do, and which are the consumers?
> 
They're used for general settings for different modules like DMA, USB, PCIe,
IPU...

Regards
Dong Aisheng
