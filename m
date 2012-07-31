From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 31 Jul 2012 10:18:15 -0600
Subject: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
In-Reply-To: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <50180547.9040603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2012 01:55 PM, Thierry Reding wrote:
> This patch series adds support for device tree based probing of the PCIe
> controller found on Tegra SoCs.

Thierry,

I think one thing that would help here would be to split up this series
into one per subsystem, and to get all the dependencies merged by the
respective maintainers. Preferably, each subsystem would export a stable
branch (perhaps consisting of just these patches) that I can then merge
into the Tegra tree and use as a basis for the PCIe driver itself.
Hopefully this approach will get more traction on all the non-Tegra
changes. Does that sound like a good plan?

Or, I can just take it all through the Tegra tree, but I'll definitely
need acks on all/most of the non-Tegra patches, since although the
patches themselves are quite small, I'd like to be sure that maintainers
are OK with the conceptual changes, like initializing PCI controllers
later than at present etc.
