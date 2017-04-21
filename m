From: robert.richter@cavium.com (Robert Richter)
Date: Fri, 21 Apr 2017 13:34:54 +0200
Subject: [PATCH 1/1] PCI: Add MCFG quirk for 2nd node of Cavium ThunderX
 pass2.x host controller
In-Reply-To: <1490789773-21506-1-git-send-email-tn@semihalf.com>
References: <1490789773-21506-1-git-send-email-tn@semihalf.com>
Message-ID: <20170421113454.GR16981@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.03.17 14:16:13, Tomasz Nowicki wrote:
> Currently SoCs pass2.x do not emulate EA headers for ACPI boot method at all.
> However, for pass2.x some devices (like EDAC) advertise incorrect base addresses
> in their BARs which results in driver probe failure during resource request.
> Since all problematic blocks are on 2nd NUMA node under domain 10 add necessary
> quirk entry to obtain BAR addresses correction using EA header emulation.
> 
> Fixes: 44f22bd91e88 ("PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller")
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> CC: stable at vger.kernel.org	# v4.10+

Acked-by: Robert Richter <rrichter@cavium.com>

Bjorn, please apply.

Thanks,

-Robert
