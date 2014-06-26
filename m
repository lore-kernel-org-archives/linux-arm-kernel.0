From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Thu, 26 Jun 2014 13:32:49 +0200
Subject: [PATCH] pinctrl: pinctrl-st.c: Cleaning up if unsigned is less than
 zero
Message-ID: <1403782369-10201-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove checking if a unsigned is less than zero

This was found using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/pinctrl/pinctrl-st.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 1bd6363bc9..f4ee1b1 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1256,7 +1256,7 @@ static int st_pctl_parse_functions(struct device_node *np,
 	func = &info->functions[index];
 	func->name = np->name;
 	func->ngroups = of_get_child_count(np);
-	if (func->ngroups <= 0) {
+	if (func->ngroups == 0) {
 		dev_err(info->dev, "No groups defined\n");
 		return -EINVAL;
 	}
-- 
1.7.10.4
