From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 May 2015 17:08:51 +0100
Subject: [PATCH 2/2] dt: mailbox: Remove 'mbox-names property is discouraged'
 message from binding
In-Reply-To: <1431360531-31337-1-git-send-email-lee.jones@linaro.org>
References: <1431360531-31337-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431360531-31337-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new API call has been introduced which allows channels to be
requested by name.  This new call uses the 'mbox-names' property,
so users need no further discouragement from supplying it.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mailbox/mailbox.txt | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mailbox.txt b/Documentation/devicetree/bindings/mailbox/mailbox.txt
index 1a2cd3d..be05b97 100644
--- a/Documentation/devicetree/bindings/mailbox/mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/mailbox.txt
@@ -22,17 +22,11 @@ Required property:
 - mboxes: List of phandle and mailbox channel specifiers.
 
 Optional property:
-- mbox-names: List of identifier strings for each mailbox channel
-		required by the client. The use of this property
-		is discouraged in favor of using index in list of
-		'mboxes' while requesting a mailbox. Instead the
-		platforms may define channel indices, in DT headers,
-		to something legible.
+- mbox-names: List of identifier strings for each mailbox channel.
 
 Example:
 	pwr_cntrl: power {
 		...
 		mbox-names = "pwr-ctrl", "rpc";
-		mboxes = <&mailbox 0
-			&mailbox 1>;
+		mboxes = <&mailbox 0 &mailbox 1>;
 	};
-- 
1.9.1
