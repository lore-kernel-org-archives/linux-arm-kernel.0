From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 26 Sep 2018 09:20:47 -0700
Subject: [RFC PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: Add
 'idle-wait-timeout-ms' setting
In-Reply-To: <7b4e5715-3a87-8f77-8d0d-4647f02c87a8@linux.intel.com>
References: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
 <20180910214519.14126-2-jae.hyun.yoo@linux.intel.com>
 <a81a6092-a9d0-78d5-3596-cddc5d6a0713@linux.intel.com>
 <20180924215850.GD18592@kunai>
 <2c8563fd-0641-5237-0026-f559c480ad91@linux.intel.com>
 <20180925082717.GB2270@kunai>
 <7b4e5715-3a87-8f77-8d0d-4647f02c87a8@linux.intel.com>
Message-ID: <f20a2e1d-e1db-1e63-3df8-ad650b931f7d@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/25/2018 9:20 AM, Jae Hyun Yoo wrote:
> On 9/25/2018 1:27 AM, Wolfram Sang wrote:
>> On Mon, Sep 24, 2018 at 03:15:46PM -0700, Jae Hyun Yoo wrote:
>>> Hi Wolfram,
>>>
>>> On 9/24/2018 2:58 PM, Wolfram Sang wrote:
>>>> On Tue, Sep 18, 2018 at 11:02:54AM -0700, Jae Hyun Yoo wrote:
>>>>> On 9/10/2018 2:45 PM, Jae Hyun Yoo wrote:
>>>>>> +- idle-wait-timeout-ms??? : bus idle waiting timeout in 
>>>>>> milliseconds when
>>>>>> +????????????? multi-master is set, defaults to 100 ms when not
>>>>>> +????????????? specified.
>>>>>
>>>>> Will change it to 'aspeed,idle-wait-timeout-ms' as it's a non standard
>>>>> property.
>>>>
>>>> No need. This binding is not a HW description, so not a DT property in
>>>> my book. I still don't understand: Your IP core in master mode does not
>>>> have a BUSY bit or similar which detects when a START was detected and
>>>> clears after a STOP?
>>>>
>>>
>>> Okay, I'll keep this property as it is then.
>>
>> Sorry for the misunderstanding. I don't think this a property, at all.
>> It doesn't describe the hardware, it is more of a configuration thing,
>> or?
>>
> 
> You are right. It doesn't describe the hardware but it needs to be
> configurable because it very depends on the peer master's behavior.
> If peer master sends a long packet usually, it should have a long
> timeout value since a slave receiving operation takes long time,
> and it should be adjusted with an optimal value with taking some
> experiments to make it not too long. Any suggestion?
> 

Should I use timeout in struct i2c_adapter instead just like i2c-mpc
does?
