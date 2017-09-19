From: afd@ti.com (Andrew F. Davis)
Date: Tue, 19 Sep 2017 10:54:34 -0500
Subject: [PATCH 2/2] tee: optee: allow selection of ti-smc as a calling
 method
In-Reply-To: <CAL_JsqJ00f3i3BQKjuVUXO8Rc_EC8BaycQi1Z_9OyRff7_kDpg@mail.gmail.com>
References: <20170918205005.30235-1-afd@ti.com>
 <20170918205005.30235-2-afd@ti.com>
 <CAL_JsqJ00f3i3BQKjuVUXO8Rc_EC8BaycQi1Z_9OyRff7_kDpg@mail.gmail.com>
Message-ID: <830b4d20-26e2-02ce-76db-b63c73967e39@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2017 08:36 AM, Rob Herring wrote:
> On Mon, Sep 18, 2017 at 3:50 PM, Andrew F. Davis <afd@ti.com> wrote:
>> On TI platforms OP-TEE must be called using a modified SMC call,
>> allow the selection of this though DT.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>  Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt | 2 ++
>>  drivers/tee/optee/core.c                                           | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
>> index d38834c67dff..a3275ecdf186 100644
>> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
>> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
>> @@ -20,6 +20,8 @@ the reference implementation maintained by Linaro.
>>                     "hvc" : HVC #0, with the register assignments specified
>>                            in drivers/tee/optee/optee_smc.h
>>
>> +                   "ti-smc" : Similar to "smc" with TI specific register
>> +                             adjustments
> 
> Sigh, really? IMO, this should be determined from the compatible
> string. Then the next TI (or any vendor) specific thing can be handled
> without a DT change.
> 

Which compatible string, do you mean the OP-TEE driver check the top
level platform compatible string?

> Maybe some day we'll figure out that not just h/w needs to be
> probe-able, but all the firmware pieces do too.
> 
> Rob
> 
