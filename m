From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Oct 2018 11:40:06 +0200
Subject: [PATCH 1/2] drm/bridge: Add virtual display DT bindings
In-Reply-To: <20180829121627eucas1p2f41ba35016ce90185f3cc08af1a67e23~PWge4MaXN2588725887eucas1p2h@eucas1p2.samsung.com>
References: <CGME20180824122324epcas3p2922f3e5415dacf4c89cfb136fa5c77b2@epcas3p2.samsung.com>
 <20180824122308.3092-1-linus.walleij@linaro.org>
 <20180827115302eucas1p24d36cfaf9835ccb217ac81e508484aa1~Ou5eTkYW-3006130061eucas1p2Z@eucas1p2.samsung.com>
 <CACRpkdaGNhxY-xAAEL1Bu4EMr8x7qTGoM9s-At2v7Ev8PwOTDw@mail.gmail.com>
 <20180829095822eucas1p1fe4336ca7944765c01fc6ad1e941b8b0~PUn7YujBw3056130561eucas1p1_@eucas1p1.samsung.com>
 <20180829100152.GL907@e110455-lin.cambridge.arm.com>
 <20180829102320eucas1p28f05f1c765eb85195a06199bb68b87ce~PU9ukgvXA1734817348eucas1p2L@eucas1p2.samsung.com>
 <20180829110045.GN907@e110455-lin.cambridge.arm.com>
 <20180829121627eucas1p2f41ba35016ce90185f3cc08af1a67e23~PWge4MaXN2588725887eucas1p2h@eucas1p2.samsung.com>
Message-ID: <CACRpkdYFh07=mghuss3reQ4+mbAOn6sU_R7ejbOHaJ9OtQ31+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 2:16 PM Andrzej Hajda <a.hajda@samsung.com> wrote:

> My question still stands: what is wrong/missing with dpi panel?

Hopefully described with my other answer :)

> I did not analyze details, but pl111 output seems to be DPI compatible.

This patch set is not trying to support the electronic device
PL111 at all. I am trying to support an emulator which has a
half-done emulation of the PL111 registers.

The other panels actually attached to real world instances
of PL111 made in silicon, all have proper drivers in
drivers/gpu/drm/panel already.

All real electronics are already covered. They use:
drivers/gpu/drm/panel/panel-arm-versatile.c
drivers/gpu/drm/bridge/dumb-vga-dac.c

All QEMU emulators are already covered (by making
QEMU emulation behave like real hardware). It now
uses DDC by way of dumb-vga-dac.c.

This virtual display in this emulator is the missing final piece to
convert the PL111 fbdev driver over to use DRM.

Yours,
Linus Walleij
