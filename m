From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 20:25:25 +0000
Subject: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120815145708.GA11331@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo7c4L=Ny=CtZwLB_XWTcN8tVWs_quuE_T+XLEGyhWwHkg@mail.gmail.com>
 <20120815145708.GA11331@avionic-0098.mockup.avionic-design.de>
Message-ID: <201208152025.25252.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 August 2012, Thierry Reding wrote:
> Yes, that was my understanding as well. So currently I haven't seen any
> problems with this because I only use one of the two host bridges. But I
> suppose I should add code to initialize the bus number aperture properly
> either via platform device resources (for the non-DT case) and the
> device tree otherwise.

I think when we last discussed this, the assumption was that each
root port has its own config space range and its own pci domain,
so you don't have to worry about bus apertures because each root port
can then have all 255 bus numbers. Has that turned out to be incorrect
now?

	Arnd
