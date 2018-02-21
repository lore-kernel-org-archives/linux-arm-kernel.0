From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 21 Feb 2018 20:54:16 +0200
Subject: [PATCH 2/2] i2c: add support for Socionext SynQuacer I2C
 controller
In-Reply-To: <CAKv+Gu_5N3bTAasc5Gt0pTo-s3mMdqmvt-C=GM0ACkkptyrN-Q@mail.gmail.com>
References: <20180220090827.913-1-ard.biesheuvel@linaro.org>
 <20180220090827.913-3-ard.biesheuvel@linaro.org>
 <CAHp75VeUJpXLpL55erp+uoMH4jqppoG5zTt1DcffqNYPsJMdUQ@mail.gmail.com>
 <CAKv+Gu8A1YKr5t0B=Fe2sF6+QT9iCVeRW+99K37g22viEoismA@mail.gmail.com>
 <CAHp75Vd=dww8AQM4tC5Z38i4PNaV4vxMFsTf=ozJ1Yw3Gd9DWg@mail.gmail.com>
 <CAKv+Gu_5N3bTAasc5Gt0pTo-s3mMdqmvt-C=GM0ACkkptyrN-Q@mail.gmail.com>
Message-ID: <CAHp75VepC+gch+st16FA8Bzisg7+X_oZg2Ua83QpHyZ43Pd5ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 8:20 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 20 February 2018 at 19:39, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Tue, Feb 20, 2018 at 8:04 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 20 February 2018 at 14:02, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

>>>>> +               ret = device_property_read_u32(&pdev->dev,
>>>>> +                                              "socionext,pclk-rate",
>>>>> +                                              &i2c->clkrate);
>>>>
>>>> I suppose for ACPI we just register a fixed rate clock and use it in
>>>> the driver in the same way as in OF case.
>>>> I guess at some point we even can provide a generic clock provider for
>>>> ACPI based on rate property.
>>
>>> Is there a question here? Do you want me to change anything?
>>
>> Is it opener for discussion. At least in the drivers we have done for
>> x86 we do the way I described.
>>
>> See, for example, drivers/mfd/intel-lpss.c

> OK, I see what you mean now. But for this driver, creating a fixed
> rate clock with no controls whatsoever, only to interrogate it for its
> rate (which we retrieved from the ACPI device node in the first place)
> seems rather pointless to me. Am I missing something here?

Somehow you are right. That's why I'm thinking that we need to provide
a generic clock provider for such cases.
It's really not a driver business to know the details of resource provider.

-- 
With Best Regards,
Andy Shevchenko
