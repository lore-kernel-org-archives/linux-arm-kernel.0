From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 24 Jun 2015 10:49:16 +0100
Subject: [PATCH v6 7/9] nvmem: qfprom: Add bindings for qfprom
In-Reply-To: <55892602.2030809@codeaurora.org>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014570-26434-1-git-send-email-srinivas.kandagatla@linaro.org>
 <55892602.2030809@codeaurora.org>
Message-ID: <558A7D1C.8050708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/06/15 10:25, Rajendra Nayak wrote:
> []..
>
>> +Example:
>> +
>> +    qfprom: qfprom at 00700000 {
>> +        compatible     = "qcom,qfprom";
>> +        reg        = <0x00700000 0x8000>;
>> +        ...
>> +        /* Data cells */
>> +        tsens_calibration: calib at 404 {
>> +            reg = <0x4404 0x10>;
>> +        };
>> +    };
>> +
>> +
>> += Data consumers =
>> +Are device nodes which consume nvmem data cells.
>> +
>> +For example:
>> +
>> +    tsens {
>> +        ...
>> +        nvmem-cell = <&tsens_calibration>;
>
> Shouldn't this be nvmem-cells instead?
>
You are correct, Will fix it in next version.

--srini
>> +        nvmem-cell-names = "calibration";
>> +    };
>>
