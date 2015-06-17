From: tj@kernel.org (Tejun Heo)
Date: Wed, 17 Jun 2015 14:17:34 -0400
Subject: [PATCH v2] ahci, msix: Fix build error for !PCI_MSI
In-Reply-To: <20150617133002.GW10428@rric.localhost>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
 <20150616132434.GO10428@rric.localhost>
 <20150616201341.GD22637@mtj.duckdns.org>
 <20150617084852.GL4914@rric.localhost>
 <5581379C.3090607@linux.intel.com>
 <20150617133002.GW10428@rric.localhost>
Message-ID: <20150617181734.GH22637@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 03:30:02PM +0200, Robert Richter wrote:
> From e43b79f0afd794d3e37ec0922c75e44b1c3f2e22 Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@cavium.com>
> Date: Wed, 17 Jun 2015 10:33:22 +0200
> Subject: [PATCH v2] ahci, msix: Fix build error for !PCI_MSI
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> It turned out the irq vector of the msix can be obtained from struct
> msix_entry. This makes the lookup function for msi_desc obsolete.
> 
> This fixes a build error if PCI_MSI is unset:
> 
>  drivers/ata/ahci.c: In function ?msix_get_desc?:
>  drivers/ata/ahci.c:1210:2: error: ?struct pci_dev? has no member named ?msi_list?
> 
> Catched by Fengguang's build bot.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Applied to libata/for-4.2.

Thanks.

-- 
tejun
