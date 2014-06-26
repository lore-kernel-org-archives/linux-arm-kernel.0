From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Thu, 26 Jun 2014 13:26:45 +0200
Subject: [PATCH] pinctrl: pinctrl-at91.c: Cleaning up if unsigned is less than
 zero
Message-ID: <1403782005-9853-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove checking if a unsigned is less than zero

This was found using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/pinctrl/pinctrl-at91.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 421493c..17ef8b3 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -945,7 +945,7 @@ static int at91_pinctrl_parse_functions(struct device_node *np,
 	/* Initialise function */
 	func->name = np->name;
 	func->ngroups = of_get_child_count(np);
-	if (func->ngroups <= 0) {
+	if (func->ngroups == 0) {
 		dev_err(info->dev, "no groups defined\n");
 		return -EINVAL;
 	}
-- 
1.7.10.4
