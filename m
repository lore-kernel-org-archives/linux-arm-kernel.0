From: yinghai@kernel.org (Yinghai Lu)
Date: Wed, 13 Feb 2013 13:20:43 -0800
Subject: Giving special alignment/size constraints to the Linux PCI core?
In-Reply-To: <201302132110.55087.arnd@arndb.de>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <201302131853.14617.arnd@arndb.de>
 <20130213191204.GA15710@obsidianresearch.com>
 <201302132110.55087.arnd@arndb.de>
Message-ID: <CAE9FiQVHQqpE+Dupcmt=dpUUEJk=3JoxsMmFf0SXtqE==YJ9Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 1:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The problem I see with the current implementation is that it reserves
> a fixed size window and does not reassign the window of the bridge
> itself, only the devices below it, at least if I am reading the
> code correctly. I have not tried this myself.

Which file?

Current code we *do* change the bridge itself resource (mmio, pref mmio, and io)
in
pciehp_configure_device/pci_assign_unassigned_bridge_resources

Let met if it does not work you.

Thanks

Yinghai
