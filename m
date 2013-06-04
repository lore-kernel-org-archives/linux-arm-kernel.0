From: horms@verge.net.au (Simon Horman)
Date: Tue, 4 Jun 2013 14:13:52 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8A7779: fix Ether device name
In-Reply-To: <20130528040043.GL13532@quad.lixom.net>
References: <1369645206-3682-1-git-send-email-horms+renesas@verge.net.au>
 <1369645206-3682-3-git-send-email-horms+renesas@verge.net.au>
 <20130528040043.GL13532@quad.lixom.net>
Message-ID: <20130604051352.GW23054@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 09:00:43PM -0700, Olof Johansson wrote:
> Hi,
> 
> 
> On Mon, May 27, 2013 at 06:00:06PM +0900, Simon Horman wrote:
> > From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > While recasting the commit "ARM: shmobile: R8A7779: add Ether support", I made a
> > typo in the platform device's name: used underscore instead of hyphen.
> 
> Minor nit: if this has been merged, then including the SHA is useful too.

Thanks, I have updated the changelog to:

ARM: shmobile: r8A7779: fix Ether device name

While recasting the commit dace48d04dee46a3409d5e13cd98031522e46377
("ARM: shmobile: R8A7779: add Ether support"), I made a
typo in the platform device's name: used underscore instead of hyphen.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[horms+renesas at verge.net.au Add SHA of referenced commit to changlog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index b0b3948..c14a69b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -443,7 +443,7 @@ void __init r8a7779_add_standard_devices(void)
 
 void __init r8a7779_add_ether_device(struct sh_eth_plat_data *pdata)
 {
-	platform_device_register_resndata(&platform_bus, "sh_eth", -1,
+	platform_device_register_resndata(&platform_bus, "sh-eth", -1,
 					  ether_resources,
 					  ARRAY_SIZE(ether_resources),
 					  pdata, sizeof(*pdata));
