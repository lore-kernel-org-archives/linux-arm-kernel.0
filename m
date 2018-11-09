From: frowand.list@gmail.com (Frank Rowand)
Date: Fri, 9 Nov 2018 08:56:40 -0800
Subject: [PATCH 1/4] of/device: Add a way to probe drivers by match data
In-Reply-To: <CAMuHMdWm2P8fa6d9vLhYtWHBe0uNPj9jfyL1rtmdLixPEi1rUg@mail.gmail.com>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <efa13e0b-0daf-3bf3-27ba-ed90f15c7dfe@gmail.com>
 <154169993998.88331.10494065577891939152@swboyd.mtv.corp.google.com>
 <0f2bb386-ba92-544c-e980-c95309944b22@gmail.com>
 <CAMuHMdWm2P8fa6d9vLhYtWHBe0uNPj9jfyL1rtmdLixPEi1rUg@mail.gmail.com>
Message-ID: <07ec49cb-e5b7-72bc-f563-2d2d7c2e2c0d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/9/18 2:36 AM, Geert Uytterhoeven wrote:
> Hi Matthias,
> 
> On Fri, Nov 9, 2018 at 11:29 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>> On 08/11/2018 18:58, Stephen Boyd wrote:
>>> Quoting Matthias Brugger (2018-11-08 00:29:46)
>>>> On 06/11/2018 19:36, Stephen Boyd wrote:
>>>>> +int platform_driver_probe_by_of_match_data(struct platform_device *pdev)
>>>>> +{
>>>>> +     int (*probe_func)(struct platform_device *pdev);
>>>>> +
>>>>> +     probe_func = of_device_get_match_data(&pdev->dev);
>>>>
>>>> Shouldn't we check if probe_func is not NULL?
>>>
>>> Is the oops from the NULL pointer deref insufficient?
>>
>> Do you think we should crash the machine if someone uses the call wrongly? Or
>> should we provide the possibility to error out on the caller side?
> 
> I believe that would be a bug in the driver, to be discovered ASAP.
> So yes, please do crash ;-)

This is one of Linus' pet peeves.  He does not think crashing the
machine is the proper choice (as a general statement).

-Frank

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
