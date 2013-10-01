From: jic23@kernel.org (Jonathan Cameron)
Date: Tue, 01 Oct 2013 22:13:02 +0100
Subject: [PATCH 07/20] Documentation: dt: iio: Add binding for LPS001WP
In-Reply-To: <524B3A19.9050509@kernel.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
 <1379347346-823-8-git-send-email-lee.jones@linaro.org>
 <524B3A19.9050509@kernel.org>
Message-ID: <524B3ADE.9060602@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/13 22:09, Jonathan Cameron wrote:
> On 09/16/13 17:02, Lee Jones wrote:
>> LPS001WP is a Pressure and Temperature sensor.
>>
>> Cc: devicetree at vger.kernel.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Hi Lee,
> 
> I'm planning to drop this set of bindings in favour of the unified ones
> proposed by Lukasz Czerwinski.
Sorry, I just realised this is unclear.  I'm proposing to drop the
documentation added in this patch in favour of the other version
in which a file per type of sensor is used rather than one per
individual sensor chip.
> 
> Could you take a look at those and perhaps propose the additional bits and pieces
> needed to ensure everything is covered by the resulting files?
> 
> Thanks,
> 
> Jonathan
>> ---
>>  .../devicetree/bindings/iio/pressure/lps001wp.txt   | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt b/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
>> new file mode 100644
>> index 0000000..45cb45c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
>> @@ -0,0 +1,21 @@
>> +* STMicroelectronics Pressure Sensor
>> +
>> +Required properties:
>> +  - compatible: Should be "st,lps001wp"
>> +  - reg: The I2C address of the sensor
>> +
>> +Optional properties:
>> +  - vdd-supply: Phandle to the Vdd supply regulator
>> +  - vddio-supply: Phandle to the Vdd-IO supply regulator
>> +
>> +Example:
>> +
>> +i2c at 80128000 {
>> +        lps001wp at 5c {
>> +                compatible = "st,lps001wp";
>> +                reg = <0x5c>;
>> +
>> +                vdd-supply = <&ab8500_ldo_aux1_reg>;
>> +                vddio-supply = <&db8500_vsmps2_reg>;
>> +        };
>> +};
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
