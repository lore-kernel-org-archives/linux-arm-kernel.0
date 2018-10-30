From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Tue, 30 Oct 2018 16:15:00 +0100
Subject: [PATCH 2/2] thermal: broadcom: constify thermal_zone_of_device_ops
 structure
In-Reply-To: <1540912500-21941-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1540912500-21941-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1540912500-21941-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal_zone_of_device_ops structure can be const as it is only
passed as the last argument of thermal_zone_of_sensor_register
and the corresponding parameter is declared as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

Unrelated to this change, is there a reason not to use
devm_thermal_zone_of_sensor_register?

 drivers/thermal/broadcom/brcmstb_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -299,7 +299,7 @@ static int brcmstb_set_trips(void *data,
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops of_ops = {
+static const struct thermal_zone_of_device_ops of_ops = {
 	.get_temp	= brcmstb_get_temp,
 	.set_trips	= brcmstb_set_trips,
 };
