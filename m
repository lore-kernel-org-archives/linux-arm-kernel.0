From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 14 Mar 2013 16:44:23 +0100
Subject: [PATCH 2/3] pwm: pwm-tiecap: Add device-tree binding support for
 da850 SOC
In-Reply-To: <5141B7CC.7000700@ti.com> (Sekhar Nori's message of "Thu, 14 Mar
 2013 17:13:08 +0530")
References: <1363257158-11615-1-git-send-email-avinashphilip@ti.com>
 <1363257158-11615-3-git-send-email-avinashphilip@ti.com>
 <5141B7CC.7000700@ti.com>
Message-ID: <87txoe56lk.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Sekhar" == Sekhar Nori <nsekhar@ti.com> writes:

 >> Required properties:
 >> -- compatible: Must be "ti,am33xx-ecap"
 >> +- compatible: Must be "ti,am33xx-ecap" or "ti,da850-ecap"
 >> - #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
 >> First cell specifies the per-chip index of the PWM to use, the second
 >> cell is the period in nanoseconds and bit 0 in the third cell is used to
 >> diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
 >> index 22e96e2..e0d96c8 100644
 >> --- a/drivers/pwm/pwm-tiecap.c
 >> +++ b/drivers/pwm/pwm-tiecap.c
 >> @@ -197,6 +197,7 @@ static const struct pwm_ops ecap_pwm_ops = {
 >> 
 >> static const struct of_device_id ecap_of_match[] = {
 >> { .compatible	= "ti,am33xx-ecap" },
 >> +	{ .compatible	= "ti,da850-ecap" },
 >> {},

 Sekhar> You add a new compatible, but don't really show any changes in
 Sekhar> driver in this series. So why can't we simply use
 Sekhar> ti,am33xx-ecap on DA850 too?

Indeed, if the hardware block is identical the dts should simply list:

compatible = "ti,da850-ecap", "ti,am33xx-ecap"

And the driver only bind to ti,am33xx-ecap (unless there ever needs to
be a da850 specific workarounde.

-- 
Bye, Peter Korsgaard
