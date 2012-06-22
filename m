From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jun 2012 16:53:31 +0000
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <CAErSpo56=S2oQ0usYfH28T0178SQUBD=5jqmcKWCT6M5WUQF6g@mail.gmail.com>
References: <4FDA2DDA.1030704@wwwdotorg.org> <201206221303.21985.arnd@arndb.de>
 <CAErSpo56=S2oQ0usYfH28T0178SQUBD=5jqmcKWCT6M5WUQF6g@mail.gmail.com>
Message-ID: <201206221653.31817.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 June 2012, Bjorn Helgaas wrote:
> The requirement (if there is one) isn't anything related to PC-ness.
> I just don't understand how things can actually work if two host
> bridges both claim the same bus number.  If we do a config read to
> that bus, both bridges should claim it and turn it into config cycles
> on their respective root buses, and we should get two responses.  I
> would expect the second response to cause an "unexpected response"
> machine check or similar.

But each PCI domain has its own config space, so if you do a config
read for one bus, it's always relative to the domain.

The part that is specific to PCs is that they don't have PCI domains
normally.

	Arnd
