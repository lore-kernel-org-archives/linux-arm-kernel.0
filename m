From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 9 Jul 2014 23:16:54 +0200
Subject: [PATCH RFC] Armada XP (mvebu) Hot-plug issues continued
In-Reply-To: <CAFJTrDsu4k80kLjF9yZzctjznbYJ74y4m-VT3Vkf3XtGQXGAMw@mail.gmail.com>
References: <CAFJTrDsu4k80kLjF9yZzctjznbYJ74y4m-VT3Vkf3XtGQXGAMw@mail.gmail.com>
Message-ID: <20140709231654.20e28529@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Matthew Minter,

On Wed, 9 Jul 2014 18:08:07 +0100, Matthew Minter wrote:

> This is something of a follow up to my previous thread:
> Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
> 
> Thanks to the helpful patches provided to the mvebu PCIe subsystem,
> hot-plug PCIe devices worked much better on this board, however I have
> discovered one remaining issue regarding them, due to the fact the
> legacy style IRQ is assigned during the fake "PCI BIOS" phase, devices
> which are plugged after boot will not be given an IRQ and thus if they
> do not support MSI/MSI-X will fail to initialize.
> 
> This seems a fairly simple problem to squash and as such I have
> written a small patch which helps solve this, however I am unsure if I
> am doing this in a sensible way or if a different kind of rework is
> needed here. Also, if this is the wrong mailing list to ask about this
> please say so.
> 
> Any comments regarding this patch or a better way to achieve this
> would be greatly appreciated. Patch follows (sorry if the format is
> off, still getting used to git format-patch).

My knowledge of the PCI core is a bit too limited to judge whether this
is the right solution or not.

However, I would recommend you to send the patch and problem
description to the linux-pci at vger.kernel.org mailing list, with Bjorn
Helgaas <bhelgaas@google.com> in the recipients (he is the PCI
subsystem maintainer).

It would indeed be good if you could use git send-email, because your
patch has been badly modified by  your e-mail client :/

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
