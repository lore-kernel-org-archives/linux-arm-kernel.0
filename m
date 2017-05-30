From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 30 May 2017 12:14:44 +0100
Subject: [PATCH v4 2/2] hwmon: (scpi) Fix the scale of SCP sensor readings
In-Reply-To: <20170530090507.16611-3-carlo@caione.org>
References: <20170530090507.16611-1-carlo@caione.org>
 <20170530090507.16611-3-carlo@caione.org>
Message-ID: <67c7a124-06fb-fa9e-18b6-5faeed030d10@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/05/17 10:05, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> The implementation details for SCPI seems to suggest that the sensor
> readings must be reported by SCP using a well defined scale
> (millidegree Celsius for temperature, millivolts for voltage,
> milliamperes for current, microwatts for power and microjoules for
> energy).
> 
> This is also important for the interaction with other subsystems: for
> example both the thermal sub-system and the hwmon sysfs interface expect
> the temperature expressed in millidegree Celsius.
> 
> Unfortunately since this behaviour is dependent on the firmware
> implementation there are cases where the sensor readings are reported
> using a different scale. For example in the Amlogic SoCs the
> temperature is reported in degree and not millidegree Celsius.
> 
> To take into account this discrepancy and fixup the values reported by
> SCP a new compatible 'amlogic,meson-gxbb-scpi-sensors' is introduced and
> used in this patch by the scpi-hwmon driver to convert the sensor
> readings to the expected scale.
> 

Looks good to me

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
