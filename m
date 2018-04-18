From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 18 Apr 2018 09:45:56 -0700
Subject: [PATCH v3 04/10] Documentations: dt-bindings: Add a document of
 PECI adapter driver for Aspeed AST24xx/25xx SoCs
In-Reply-To: <CAL_Jsq+9YDv04Gu=WODdqb6wD4fk6=-fFw_3skU79UC8OW0jZA@mail.gmail.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com>
 <20180416181035.rcjvt4rlrwaj5yxf@rob-hp-laptop>
 <53ff5b2b-eba8-8311-64a9-abd4bc72226d@linux.intel.com>
 <CAL_Jsq+1wC-KhXPeCSNhCeCih6=CatJbyumO51ucD17Rt7qofw@mail.gmail.com>
 <f07623c4-5f0c-4ab1-f761-44bd702bbdf0@linux.intel.com>
 <584aca6c-c87a-ff7a-2fdc-3c742236be60@linux.intel.com>
 <CAL_Jsq+9YDv04Gu=WODdqb6wD4fk6=-fFw_3skU79UC8OW0jZA@mail.gmail.com>
Message-ID: <7ff3b23c-7dc8-865f-4069-c53642aaf1ab@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/18/2018 6:59 AM, Rob Herring wrote:
> On Tue, Apr 17, 2018 at 5:06 PM, Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>> On 4/17/2018 11:16 AM, Jae Hyun Yoo wrote:
>>>
>>> On 4/17/2018 6:16 AM, Rob Herring wrote:
>>>>
>>>> On Mon, Apr 16, 2018 at 6:12 PM, Jae Hyun Yoo
>>>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>>>
>>>>> On 4/16/2018 11:10 AM, Rob Herring wrote:
>>>>>>
>>>>>>
>>>>>> On Tue, Apr 10, 2018 at 11:32:06AM -0700, Jae Hyun Yoo wrote:
>>>>>>>
>>>>>>>
>>>>>>> This commit adds a dt-bindings document of PECI adapter driver for
>>>>>>> Aspeed
>>>>>>> AST24xx/25xx SoCs.
>>>>
>>>>
>>>> [...]
>>>>
>>>>>>> +- clocks            : Should contain clock source for PECI
>>>>>>> controller.
>>>>>>> +                     Should reference clkin.
>>>>>>> +- clock_frequency   : Should contain the operation frequency of PECI
>>>>>>> controller
>>>>>>> +                     in units of Hz.
>>>>>>> +                     187500 ~ 24000000
>>>>>>
>>>>>>
>>>>>>
>>>>>> This is the frequency of the bus or used to derive it? It would be
>>>>>> better to specify the bus frequency instead and have the driver
>>>>>> calculate its internal freq. And then use "bus-frequency" instead.
>>>>>>
>>>>>
>>>>> I agree with you. Actually, it is being used for operation frequency
>>>>> setting
>>>>> of PECI controller module in SoC so it's different from the meaning of
>>>>> "bus-frequency". I'll change it to "operation-frequency".
>>>>
>>>>
>>>> No, now you've gone from a standard property name to something custom.
>>>> Why do you need to set the frequency in DT if it is not related to the
>>>> interface frequency?
>>>>
>>>> Rob
>>>>
>>>
>>> Actually, the interface frequency is affected by the operation frequency
>>> but there is no description of its relationship in datasheet. I'll check
>>> again about the detail to ASPEED chip vendor and will use
>>> 'bus-frequency' if available.
>>>
>>
>> I investigated it more deeply. Basically, by the spec, PECI bus speed
>> cannot be set as a fixed speed. A PECI bus can have a wide speed range
>> from 2Kbps to 2Mbps which is dynamically set by a handshaking sequence
>> between an originator and clients called 'timing negotiation' in spec.
>> This timing negotiation behavior happens on every single transaction so the
>> bus speed also can vary on every transactions. So I'm thinking a custom
>> property name for it, 'peci-clk-frequency' if it is acceptable.
> 
> Okay, seems bus-frequency is not appropriate here. So use
> 'clock-frequency' (note the '-' not '_' as that is the standard
> property).
> 
> Rob
> 

Thanks! I'll use 'clock-frequency' for it.

Jae
