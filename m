From: wahrenst@gmx.net (Stefan Wahren)
Date: Wed, 10 Sep 2014 19:24:09 +0200
Subject: [PATCH RFC 2/3] ARM: regulator: add Freescale MXS regulator driver
In-Reply-To: <20140910141853.GA4994@leverpostej>
References: <1410089869-6611-1-git-send-email-info@lategoodbye.de>
 <1410089869-6611-3-git-send-email-info@lategoodbye.de>
 <20140909182211.GG3896@leverpostej> <540F523D.4010904@lategoodbye.de>
 <20140910141853.GA4994@leverpostej>
Message-ID: <54108939.5050208@gmx.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 10.09.2014 16:18, schrieb Mark Rutland:
>[...]
>
>>>> +       of_property_read_u32(np, "mxs-default-microvolt",
>>>> +                                  &val);
>>>> +
>>>> +       if (val)
>>>> +               mxs_set_voltage(rdev, val, val, NULL);
>>>
>>> As I mentioned in my comments on the binding, I'd like to know why this
>>> is necessary and if it is why it shouldn't be a standardised property.
>>
>>   From my understanding the standardised properties only defines a range,
>> but no default state of the regulators. If the initialization from the
>> bootloader or a hardcoded initialization in the driver is okay then the
>> property is not necessary.
>
> Sure. My questions was why it is necessary to preconfigure the
> regulators at all rather than why it is necessary to do so in this
> manner.
>
> Mark.
>

sorry i don't have a clue. In the original code there isn't a comment 
about the reason. Currently there is no init of the vddio regulator by 
the kernel and everything works fine.

@Fabio: Do you have any doubts?

Stefan
