From: olof@lixom.net (Olof Johansson)
Date: Sun, 6 Jul 2014 17:38:54 -0700
Subject: [GIT PULL 1/3] ARM: tegra: rework PCIe regulators
In-Reply-To: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140707003854.GD8469@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 03:23:44PM -0600, Stephen Warren wrote:
> This branch reworks the set of regulators that the Tegra PCIe driver
> uses, so that the driver and DT bindings more correctly model what's
> really going on in HW.
> 
> I've made this a separate branch in case it needs to be pulled into the
> PCIe tree to resolve any conflicts. Any branch that adds Tegra124
> support to the PCIe driver will need to be based on this branch, and
> such patches might show up for 3.17, and be taken through the ARM tree
> so we can manage our own dependencies.

Isn't PCI broken if you boot with an older device tree now?

I would like to see this as two branches: One to the PCI driver, and one
modifying DT contents. The PCI driver should remain working for old DTs,
so the last couple of commits on this branch can't be there.


-Olof
