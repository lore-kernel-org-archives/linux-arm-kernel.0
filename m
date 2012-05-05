From: lee.jones@linaro.org (Lee Jones)
Date: Sat, 05 May 2012 07:30:19 +0100
Subject: [PATCH 06/15] mfd/ab8500: Remove confusing ab8500-i2c file and
 merge into ab8500-core
In-Reply-To: <4FA448FA.8000404@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-7-git-send-email-lee.jones@linaro.org>
 <201205042025.15421.arnd@arndb.de> <4FA448FA.8000404@linaro.org>
Message-ID: <4FA4C8FB.4090202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whoops, I put that comment in the wrong place. Let me amend:

On 04/05/12 22:24, Lee Jones wrote:
> On 04/05/12 21:25, Arnd Bergmann wrote:
>> On Friday 04 May 2012, Lee Jones wrote:
>>>
>>> ab8500-i2c is used as core code to register the ab8500 device.
>>> After allocating ab8500 memory, it immediately calls into
>>> ab8500-core where the real initialisation takes place. This
>>> patch moves all core registration and memory allocation into
>>> the true ab8500-core file and removes ab8500-i2c completely.
>>>
>>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>>
>> These changes all look good, but I think I would go further here.
>> I believe we discussed this and I agreed that we could leave that
>> for later, but upon reading this code, I think now that it's getting
>> rather silly.

It's something I'm happy to do, but wasn't the point of the patch. I
don't know much about this code, as I didn't write it. I can spend more 
time on clean-ups such as these after my DT task has been completed.

<snip>

>> If you apply this patch below, then there is no reason to add any of
>> those.
 >>
>> There is room for additional simplification even, but this is the most
>> important one. Note that the ab8500 mutex was only needed to support the
>> case where write_masked is not present, and that the debug output
>> on error is pointless because the prcmu driver already writes the same
>> output. The next step would be to remove all the {get,set}_register
>> functions
>> from ab8500 and just call the prcmu directly.
>>
>> Signed-off-by: Arnd Bergmann<arnd@arndb.de>

Patch looks good. I'll test it when I have my board. If it doesn't cause 
any issues I'll apply it to the patch-set ready for pull-request.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
