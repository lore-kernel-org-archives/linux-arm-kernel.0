From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 16 Jun 2015 19:55:58 +0530
Subject: [PATCH-V2 12/12] Documentation: binding: add sclk adjustment
 properties to i2c-pxa
In-Reply-To: <CAL_JsqKu0BFLU8JdxDwrkn2SZTQPX6GYu2AFOYP49zknfu28Tw@mail.gmail.com>
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1434383399-2370-13-git-send-email-vaibhav.hiremath@linaro.org>
 <CAL_JsqKu0BFLU8JdxDwrkn2SZTQPX6GYu2AFOYP49zknfu28Tw@mail.gmail.com>
Message-ID: <558031F6.5050107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 16 June 2015 06:52 PM, Rob Herring wrote:
> On Mon, Jun 15, 2015 at 10:49 AM, Vaibhav Hiremath
> <vaibhav.hiremath@linaro.org> wrote:
>> With addition of PXA910 family of devices, the TWSI module supports
>> new feature which allows us to adjust SCLK.
>> With DT properties i2c-pxa driver takes input configuration
>> in nsec and converts it to respective bit-fields,
>>
>>   - i2c-sclk-low-time-ns : SCLK low time (tlow)
>>     This property is used along with mode selection.
>>   - i2c-sclk-high-time-ns : SCLK high time (thigh)
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
>> index 9657db5..0fafd91 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
>> @@ -23,12 +23,25 @@ Optional properties :
>>    - i2c-disable-after-xfer : If set, driver will disable I2C module
>>      after msg xfer and enable it again before xfer.
>>
>> +   (Applicable to PXA910 family):
>> +
>> + - i2c-sclk-low-time-ns : SCLK low time (tlow), for standard/fast/high
>> +   speed mode.
>> +   This property is used along with mode selection. Driver uses this property
>> +   to set low/high time for standard and fast speed mode, as counter bit-field
>> +   is same for both.
>
> This belongs below both properties, and it should be clear that both
> properties are required if present.
>

Technically, both properties are required only in case of high_mode.

As mentioned above, in case of standard and fast mode we use tLow value.

Thanks,
Vaibhav
