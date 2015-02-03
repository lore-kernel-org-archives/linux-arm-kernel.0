From: rjui@broadcom.com (Ray Jui)
Date: Tue, 3 Feb 2015 12:16:04 -0800
Subject: [PATCH v3 3/4] pinctrl: cygnus: add initial IOMUX driver support
In-Reply-To: <20150203200009.GB15969@dtor-ws>
References: <rjui@broadcom.com>
 <1422928894-20716-1-git-send-email-rjui@broadcom.com>
 <1422928894-20716-4-git-send-email-rjui@broadcom.com>
 <20150203174042.GA15969@dtor-ws> <54D121A0.6070602@broadcom.com>
 <20150203200009.GB15969@dtor-ws>
Message-ID: <54D12C84.9020505@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/3/2015 12:00 PM, Dmitry Torokhov wrote:
> On Tue, Feb 03, 2015 at 11:29:36AM -0800, Ray Jui wrote:
>> On 2/3/2015 9:40 AM, Dmitry Torokhov wrote:
>>> On Mon, Feb 02, 2015 at 06:01:33PM -0800, Ray Jui wrote:
>>>> +
>>>> +/*
>>>> + * List of pins in Cygnus
>>>> + */
>>>> +static struct cygnus_pin cygnus_pins[] = {
>>>
>>> const?
>>>
>> I cannot make it const here, since the address of "gpio_mux" is later
>> passed to pinctrl_pin_desc's private data:
>>
>> pins[i].drv_data = &cygnus_pins[i].gpio_mux;
> 
> The pinctrl code says:
> 
> "@drv_data: driver-defined per-pin data. pinctrl core does not touch
> this"
> 
> so we could theoretically cast away the constness and restore it when
> we access drv_data in pin control methods, but I won't insist. I am
> not sure which way looks nicer.
> 
> Thanks.
> 
Yeah, I agreed that by declaring the cygnus_pins array const, it makes
it more obvious that "we do not expect any of its parameters to change."
But later if we cast &gpio_mux to void * before assigned to drv_data of
pinctrl_pin_desc, we sort of break it up...I'll keep this part of code
as it is for now.

Thanks,

Ray
