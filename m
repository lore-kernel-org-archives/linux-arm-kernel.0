From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 13 Dec 2016 14:09:29 +0000
Subject: [PATCH v3] firmware: arm_scpi: fix reading sensor values on
 pre-1.0 SCPI firmwares
In-Reply-To: <20161211211432.13252-2-martin.blumenstingl@googlemail.com>
References: <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
 <20161211211432.13252-1-martin.blumenstingl@googlemail.com>
 <20161211211432.13252-2-martin.blumenstingl@googlemail.com>
Message-ID: <db2067d3-74bf-fbc8-c687-f826d5968ad7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/12/16 21:14, Martin Blumenstingl wrote:
> The pre-1.0 SCPI firmwares are using one __le32 as sensor value, while
> the 1.0 SCPI protocol uses two __le32 as sensor values (a total of
> 64bit, split into 32bit upper and 32bit lower value).
> Using an "struct sensor_value" to read the sensor value on a pre-1.0
> SCPI firmware gives garbage in the "hi_val" field. Introducing a
> separate function which handles scpi_ops.sensor_get_value for pre-1.0
> SCPI firmware implementations ensures that we do not read memory which
> was not written by the SCPI firmware (which fixes for example the
> temperature reported by scpi-hwmon).
> 
> Suggested-by: Sudeep Holla <Sudeep.Holla@arm.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Will send to ARM SoC once the SCPI changes land in mainline or post -rc1.

-- 
Regards,
Sudeep
