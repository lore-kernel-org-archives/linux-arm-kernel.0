From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 6 Sep 2018 13:47:47 +0200
Subject: [PATCH v3 27/30] ARM: dts: sun8i: h3: use calibration for ths
In-Reply-To: <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
Message-ID: <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.09.2018 18:46, Emmanuel Vadot wrote:
>> +			/* Data cells */
>> +			thermal_calibration: calib at 234 {
>> +				reg = <0x234 0x8>;
>> +			};
>   You are declaring 8 bytes of calibration data but to my knowledge it's
> only 2 bytes per sensor, so 2 bytes for H3.
>   Am I missing something ?
> 
>   Thanks,

Emmanuel you are right, it is 2 bytes per Sensor and should be 2 bytes 
for H3, but the thermal calibration data field is on all chips 64 bit 
wide - so 8 bytes. So I'm reading here the complete calibration data field.

Philipp
