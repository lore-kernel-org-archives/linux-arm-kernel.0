From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 24 Nov 2013 11:54:53 -0500
Subject: [PATCH] ARM: dove: Fix typo in device_type property of phy node
In-Reply-To: <1384440899-3622-1-git-send-email-srinivas.kandagatla@st.com>
References: <1384440899-3622-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20131124165453.GF29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:54:59PM +0000, Srinivas Kandagatla wrote:
> This patch fixes a typo for device_type property of phy node.
> This can work as of today but once a checks are added in generic code
> this typo will stop phy from working.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
>  arch/arm/boot/dts/dove.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to mvebu/dt with Andrew's Ack.  I had to hand add it due to the
reworking of dove.dtsi last time around.  I've attached my version, let
me know if it looks amiss.

thx,

Jason.

----------->8---------------------
commit 9e52c63992c19b1d2e9a6b6b8ba61aaf35e9fd17
Author: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Date:   Sun Nov 24 16:47:51 2013 +0000

    ARM: dove: Fix typo in device_type property of phy node
    
    This patch fixes a typo for device_type property of phy node.
    This can work as of today but once a checks are added in generic code
    this typo will stop phy from working.
    
    Acked-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 113a8bc7bee7..abd7a6fd77f1 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -559,7 +559,7 @@
 				status = "disabled";
 
 				ethphy: ethernet-phy {
-					device-type = "ethernet-phy";
+					device_type = "ethernet-phy";
 					/* set phy address in board file */
 				};
 			};
