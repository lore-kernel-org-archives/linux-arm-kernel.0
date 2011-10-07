From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Oct 2011 10:54:08 +0200
Subject: [PATCH 0/14] Sparse fixes for tegra
In-Reply-To: <1317956064-17650-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
Message-ID: <1578886.3aVd19SPzO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 October 2011 19:54:10 Olof Johansson wrote:
> Some trivial fixes removing sparse warnings on tegra code.

Hi Olof,

That's a very nice series. I had a go at this across platforms before,
but had not finished it yet.

One thing I would recommend instead of having a type cast in IO_ADDRESS
is to change the definition of IO_{IRAM,CPU,PPSB,APB}_VIRT to be
an iomem pointer from the start, so any calculation you do based on
that automatically gets the right type.

In the long run, I would hope to be able to get rid of basically
all uses of IO_ADDRESS and IO_TO_VIRT in the tegra code and replace
that with device tree lookups, but that is clearly a separate issue.

	Arnd
