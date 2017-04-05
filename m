From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Wed,  5 Apr 2017 07:28:46 +0200
Subject: [PATCH 1/1] ARM: dts: armada-xp-linksys-mamba: use wan instead of
 internet for DSA port
Message-ID: <20170405052847.326-1-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LEDs for the "wan" port are already labeled "mamba:amber:wan" resp.
"mamba:white:wan". So besides being an outlier with regard to the rest
of the product line (see table below) changing the label fixes an
internal inconsistency as well.

This will be visible in user space. Given commit cb4f71c42988 ("ARM:
dts: armada-38x: change order of ethernet DT nodes on Armada 38x") it's
expected to happen anyway. Commit 499400c9ac20 ("ARM: dts:
armada-xp-linksys-mamba: Utilize new DSA binding") switches to the new
bindings, use this opportunity to do it now rather than later.

|-----------------------------------------------------------------|
| Labels used for the case and those used for the DSA ports       |
|-----------------------------------------------------------------|
| case labels	| armada-385-linksys-*	| armada-xp-linksys-mamba |
|---------------|-----------------------|-------------------------|
| internet	| wan			| internet		  |
| 1		| lan1			| lan1			  |
| 2		| lan2			| lan2			  |
| 3		| lan3			| lan3			  |
| 4		| lan4			| lan4			  |
|-----------------------------------------------------------------|

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---

Hi everybody,

I underestimated the urge of people to make all the same before. While I do not
particularly like this sort of change I see it coming anyway. So this patch is
meant to make it a deliberate decision so it no longer is an item lurking in
the shadows. Whether this patch gets taken or rejected my goal is reached.

In hindsight wan would have been the better choice.

Ralph

 arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 9efcf59..0143aed 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -354,7 +354,7 @@
 
 			port at 4 {
 				reg = <4>;
-				label = "internet";
+				label = "wan";
 			};
 
 			port at 5 {
@@ -452,7 +452,7 @@
 
 			port at 4 {
 				reg = <4>;
-				label = "internet";
+				label = "wan";
 			};
 
 			port at 5 {
-- 
2.10.2
