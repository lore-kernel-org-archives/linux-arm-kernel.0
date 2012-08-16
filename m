From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 07:03:50 +0000
Subject: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120816045539.GA17067@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <201208152025.25252.arnd@arndb.de>
 <20120816045539.GA17067@avionic-0098.mockup.avionic-design.de>
Message-ID: <201208160703.50364.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Thierry Reding wrote:
> At least for the config space this is incorrect. There's a single region
> to access the configuration space for all devices below the PCIe
> controller. So it is shared by both (Tegra20) or all three (Tegra30)
> root ports.
> 
> I'm not sure about PCI domains. Do you have any good pointers as to
> where I could read up on them? If they need special hardware support,
> then I think Tegra doesn't support them either. At least I haven't come
> across any mention of domains while going through the, admittedly some-
> what sparse on PCIe, Tegra documentation.

I was referring to the same thing here: if you had a separate config
space for each root port, they would by definition be separate PCI
domain. So you don't have them.

	Arnd
