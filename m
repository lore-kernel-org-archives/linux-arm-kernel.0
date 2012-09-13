From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Thu, 13 Sep 2012 12:25:27 +0530
Subject: [PATCHv8 00/23]I2C big cleanup
In-Reply-To: <50517780.2080002@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <874nn2vpv9.fsf@deeprootsystems.com> <50517780.2080002@ti.com>
Message-ID: <5051835F.3050102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 September 2012 11:34 AM, Shubhrajyoti wrote:
> > At least on 3530/Overo and 3730/Overo, CORE no longer hits retenion (or
> > off) during idle.  
I dont have an Overo, anyways will see if I can get one

However on beagleXm even off count increases

/ # grep "^core_pwrdm" /debug/pm_debug/count
core_pwrdm
(ON),OFF:48,RET:856,INA:0,ON:905,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
/ # cat /sys/devices/platform/omap_i2c.*/power/runtime_status
suspended
suspended
/ #
/ #
/ # cat /sys/devices/platform/omap_i2c.*/power/autosuspend_delay_ms
1000
1000
/ #
/ #
/ # grep "^core_pwrdm" /debug/pm_debug/count
core_pwrdm
(ON),OFF:218,RET:856,INA:0,ON:1075,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
/ #
