From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Thu, 26 Jun 2014 15:44:32 +0200
Subject: [PATCH] pinctrl: pinctrl-st.c: Cleaning up values that are never used
Message-ID: <1403790272-11635-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove variable that are never used

This was found using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/pinctrl/pinctrl-st.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 1bd6363bc9..d3bd687 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1178,9 +1178,7 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 	const __be32 *list;
 	struct property *pp;
 	struct st_pinconf *conf;
-	phandle phandle;
 	struct device_node *pins;
-	u32 pin;
 	int i = 0, npins = 0, nr_props;
 
 	pins = of_get_child_by_name(np, "st,pins");
@@ -1218,8 +1216,8 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 		conf = &grp->pin_conf[i];
 
 		/* bank & offset */
-		phandle = be32_to_cpup(list++);
-		pin = be32_to_cpup(list++);
+		be32_to_cpup(list++);
+		be32_to_cpup(list++);
 		conf->pin = of_get_named_gpio(pins, pp->name, 0);
 		conf->name = pp->name;
 		grp->pins[i] = conf->pin;
-- 
1.7.10.4
