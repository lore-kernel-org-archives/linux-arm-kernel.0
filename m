From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 23 Jun 2014 18:03:18 -0400
Subject: [PATCH v3] ARM: mvebu: Use system controller to get the soc id
 when possible
In-Reply-To: <1403538128-27859-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403538128-27859-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140623220318.GE10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 05:42:08PM +0200, Gregory CLEMENT wrote:
> On Armada 38x it is possible to get the SoC Id and the revision
> without using the PCI register. Accessing the PCI registers implies
> enabling its clock and, because of the initialization issue, not
> keeping them enable. So if possible it is better to avoid it.
> 
> Armada 370 and Armada XP provides the SoC ID values from the system
> controller but not the revision.
> 
> Armada 375 provides both but the SoC ID value looks buggy (0x6660
> instead of 0x6720).
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi,
> 
> The main difference with the previous version is the use of
> marvell,aramda380 instead of marvell,aramda38x which have been removed
> in a previous patch.
> 
> Thanks,
> 
> Gregory
> 
> Changelog:
> 
> v1 -> v2:
> 
> - Fix typo in mvebu_system_controller_get_soc_id.
> - Use -ENODEV as return value instead of -1
> 
> v2 -> v3:
> 
> - Use marvell,aramda380 as compatible string
> - Fix a typo
> - Remove a white space
> 
>  arch/arm/mach-mvebu/common.h            |  1 +
>  arch/arm/mach-mvebu/mvebu-soc-id.c      | 19 ++++++++++++++++++-
>  arch/arm/mach-mvebu/system-controller.c | 19 +++++++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)

Applied to mvebu/soc

thx,

Jason.
