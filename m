From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Sep 2011 09:54:20 +0200
Subject: [PATCH] mach-integrator: fix VGA base regression
In-Reply-To: <4E6620CF.3020201@gmail.com>
References: <1315172408-18957-1-git-send-email-linus.walleij@linaro.org>
	<4E64496E.1090000@gmail.com>
	<CACRpkdYw4WCJ+kBm_FBH=H-vPKBUsb9DFToK0MN4F8t5T8Tc9g@mail.gmail.com>
	<4E64EB24.7010800@gmail.com>
	<CAKnu2MrFsnZrq-Fzq3HpV8oAwa9Vi6fFqrSSB7+kq8r8V7ANQg@mail.gmail.com>
	<4E6620CF.3020201@gmail.com>
Message-ID: <CAKnu2Mq3Thw-ybCgPouKDa2tRCJc=-ny+yvKbBwR5TPTuU5W2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/6 Rob Herring <robherring2@gmail.com>:

> Integrator and footbridge are the only platforms that would ever
> actually work with VGA console (...)

Hm I wonder if I can test this. Can I just plug some arbitrary
VGA-capable graphics card into an empty PCI socket and
expect the console to come up?

> the others are all returning a
> physical address rather than a virtual address. kirkwood, dove, mv78xx0,
> and orion5x are all wrong. I'm not sure on shark. Seems to be a virtual
> address, but it's not mapped.
>
> So perhaps the correct fix is just to remove the initialization of
> vga_base on all these platforms.

Sounds like a pretty good idea, but since I ran into the
problem, what's actually happening in these systems on
boot? Are they reading/writing some arbitrary physical
location as if it was a virtual address?

Linus
