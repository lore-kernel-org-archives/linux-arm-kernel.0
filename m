From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu, 5 Jan 2017 14:30:49 -0800
Subject: [PATCH v2 05/19] ARM: dts: imx6-sabresd: add OV5642 and OV5640
 camera sensors
In-Reply-To: <c8c09060-dd6b-f495-da7d-b1f9fad79b89@mentor.com>
References: <1483477049-19056-1-git-send-email-steve_longerbeam@mentor.com>
 <1483477049-19056-6-git-send-email-steve_longerbeam@mentor.com>
 <c8c09060-dd6b-f495-da7d-b1f9fad79b89@mentor.com>
Message-ID: <eadcb725-476b-5e4f-a17f-207b9dedb358@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/04/2017 04:33 AM, Vladimir Zapolskiy wrote:
>
>> +
>> +	camera: ov5642 at 3c {
> ov5642: camera at 3c

done.

>> +		pwdn-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>; /* SD1_DAT0 */
>> +		reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>; /* SD1_DAT1 */
> Comments about SD1_* pad names are redundant.

sure, removed.

>> +		status = "disabled";
> Why is it disabled here?

It's explained in the header. I don't yet have the OV5642 module for
the sabresd for testing, so it is disabled for now.

>> +
>> +	mipi_camera: ov5640 at 3c {
> ov5640: camera at 3c

done.

>
>> +		pwdn-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>; /* SD1_DAT2 */
>> +		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>; /* SD1_CLK */
> Comments about SD1_* pad names are redundant.

removed.

>> +
>> +		pinctrl_ipu1_csi0: ipu1grp-csi0 {
> Please rename the node name to ipu1csi0grp.
>
> Please add new pin control groups preserving the alphanimerical order.

done and done.


Steve
