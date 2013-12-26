From: horms@verge.net.au (Simon Horman)
Date: Thu, 26 Dec 2013 14:30:19 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Conditionally select MICREL_PHY
In-Reply-To: <52B37BAC.4090405@cogentembedded.com>
References: <1387153872-8387-1-git-send-email-horms+renesas@verge.net.au>
 <52B37BAC.4090405@cogentembedded.com>
Message-ID: <20131226053015.GA9638@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 02:05:16AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/16/2013 03:31 AM, Simon Horman wrote:
> 
> >The koelsch board uses has an SH ethernet controller which uses a Micrel
> >phy. Select MICREL_PHY for koelsch if SH_ETH is enabled to make use of the
> >Micrel-specific phy driver rather than relying on the generic phy driver.
> 
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/mach-shmobile/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> >diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> >index f01e878..670238a 100644
> >--- a/arch/arm/mach-shmobile/Kconfig
> >+++ b/arch/arm/mach-shmobile/Kconfig
> >@@ -41,6 +41,7 @@ config MACH_GENMAI
> >  config MACH_KOELSCH
> >  	bool "Koelsch board"
> >  	depends on ARCH_R8A7791
> >+	select MICREL_PHY if SH_ETH
> >
> >  config MACH_KZM9D
> >  	bool "KZM9D board"
> 
>    Simon, did you initially remove that hunk when committing?

Thanks for noticing.

I will queue up the following:

From: Simon Horman <horms+renesas@verge.net.au>

ARM: shmobile: koelsch: Conditionally select MICREL_PHY for Multiplatform

The koelsch board uses has an SH ethernet controller which uses a Micrel
phy. Select MICREL_PHY for koelsch if SH_ETH is enabled to make use of the
Micrel-specific phy driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a127252..958ccf3d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -45,6 +45,7 @@ config MACH_GENMAI
 config MACH_KOELSCH
 	bool "Koelsch board"
 	depends on ARCH_R8A7791
+	select MICREL_PHY if SH_ETH
 
 config MACH_KZM9D
 	bool "KZM9D board"
-- 
1.8.4
