From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Mar 2014 09:27:48 +0900
Subject: [PATCH] ARM: shmobile: koelsch-reference: Annotate clk_names as
 __initconst
In-Reply-To: <5326E154.9040800@cogentembedded.com>
References: <1395022796-3199-1-git-send-email-horms+renesas@verge.net.au>
 <5326E154.9040800@cogentembedded.com>
Message-ID: <20140318002748.GB6275@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 03:49:40PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 17-03-2014 6:19, Simon Horman wrote:
> 
>    Apparently you meant clk_enables in the subject, not clk_names.

Thanks, I have queued up the following:


From: Simon Horman <horms+renesas@verge.net.au>

ARM: shmobile: koelsch-reference: Annotate clk_enables as __initconst

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index a39114a..63117d52 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -110,7 +110,7 @@ static const struct clk_name clk_names[] __initconst = {
 /*
  * This is a really crude hack to work around core platform clock issues
  */
-static const struct clk_name clk_enables[] = {
+static const struct clk_name clk_enables[] __initconst = {
 	{ "ether", NULL, "ee700000.ethernet" },
 	{ "i2c2", NULL, "e6530000.i2c" },
 	{ "msiof0", NULL, "e6e20000.spi" },
-- 
1.8.5.2
