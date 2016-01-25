From: peter@hurleysoftware.com (Peter Hurley)
Date: Mon, 25 Jan 2016 08:14:55 -0800
Subject: [PATCH 1/3] printk: make preferred_console local static bool
In-Reply-To: <56A62314.3020803@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
 <1453725901.28952.53.camel@perches.com> <56A61A6F.10409@linaro.org>
 <1453728205.28952.62.camel@perches.com> <56A62314.3020803@linaro.org>
Message-ID: <56A649FF.1070505@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2016 05:28 AM, Aleksey Makarov wrote:
> 
> 
> On 25.01.2016 19:23, Joe Perches wrote:
>> On Mon, 2016-01-25 at 18:51 +0600, Aleksey Makarov wrote:
>>>
>>> On 25.01.2016 18:45, Joe Perches wrote:
>>>> On Mon, 2016-01-25 at 17:45 +0600, Aleksey Makarov wrote:
>>>>> The variable preferred_console is used only inside register_console()
>>>>> and it's semantics is boolean.  Make it clear.
>>>>
>>>> This loses the index of the preferred console.
>>>> I'm not sure this is better.
>>>
>>> That index is not used anywhere.  I believe the patch makes things clear.
>>
>> Well, with this change the name and its use
>> is a bit misleading.  Maybe changing it to
>> something like use_selected_console is better.
> 
> Thank you. I will fix this in the next version.

Ideally, the transform should be

 preferred_console => has_preferred
 selected_console => preferred_console

This would match the actual use of add_preferred_console()

Regards,
Peter Hurley
