From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 15:06:23 +0100
Subject: [PATCH] PCI: mvebu: Restrict build to 32-bit ARM
In-Reply-To: <1455802330-17565-1-git-send-email-thierry.reding@gmail.com>
References: <1455802330-17565-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <5051836.EUN3ennYNm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 14:32:10 Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This driver uses PCI glue that is only available on 32-bit ARM. This
> used to work fine as long as ARCH_MVEBU and ARCH_DOVE were exclusively
> 32-bit, but that's changed now, with ARCH_MVEBU also being available
> on 64-bit ARM.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Looks fine as a temporary workaround, but I think what we really want to
do here is to remove the dependency, as the new ARM64 platforms are going
to need this driver anyway.

	Arnd
