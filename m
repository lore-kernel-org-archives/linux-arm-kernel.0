From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2017 21:00:14 +0100
Subject: [PATCH 1/4] PCI: add DT bindings for Cortina Gemini PCI Host
 Bridge
In-Reply-To: <20170131003137.GE20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170131003137.GE20550@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <CACRpkdZFHBufh1ZunKnY018_TN-s80drQ_f-KTtPoR6O5OGHrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 1:31 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:

>> +- bus-range: set to <0x00 0x00> (only root bus)
>
> Why is this limited to bus 0?  Is everything completely soldered down
> with no possibility of adding or replacing PCI devices? The interrupt-map
> below suggests slots, though.  If there's a slot, we could plug in a card
> with a bridge, which would mean more than just bus 0.

I thought so because it's a NAS box (the typical usecase) but when I
dismantled it and turned it over, wow, there is indeed a MiniPCI
slot!

OK I will augment this to 0x00 0xff.

Yours,
Linus Walleij
