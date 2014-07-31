From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 01 Aug 2014 01:31:18 +0200
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DAD0AA.7040105@gmail.com>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <53DA936E.9060004@gmail.com> <53DA9709.10602@suse.de>
 <53DA9BA9.60808@gmail.com> <53DACE73.8080009@suse.de>
 <53DAD0AA.7040105@gmail.com>
Message-ID: <53DAD1C6.9070102@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.08.2014 01:26, schrieb Tomasz Figa:
> On 01.08.2014 01:17, Andreas F?rber wrote:
>> Am 31.07.2014 21:40, schrieb Tomasz Figa:
>>> On 31.07.2014 21:20, Andreas F?rber wrote:
>>>> Am 31.07.2014 21:05, schrieb Tomasz Figa:
>>>>> On 31.07.2014 18:08, Andreas F?rber wrote:
> [snip]
>>>>>> +&dp_hpd {
>>>>>> +	samsung,pins = "gpc3-0";
>>>>>> +	samsung,pin-function = <0>;
>>>>>> +	samsung,pin-pud = <3>;
>>>>>> +	samsung,pin-drv = <0>;
>>>>>> +};
>>>>>
>>>>> Hmm, what node is this referencing? I believe this should rather
>>>>> reference the pin controller and add a new board-specific pinconf/pinmux
>>>>> group instead....
>>>>
>>>> It's a -pinctrl node. See v3->v4 change log and discussion on v3.
>>>>
>>>
>>> Well, this is clearly a board specific node anyway, because it does not
>>> refer to a special function, but simply an input/interrupt GPIO. If it
>>> somehow has landed in generic pinctrl dtsi then it should be removed
>>> from there and this patch should simply introduce its own instance of
>>> dp_hpd node, so you did the right thing in v3.
>>
>> Well, my point was that the 3.8 tree contains only one dp-hpd node, not
>> two as we would get by adding a new node here.
>>
>> Apart from Spring, it's used in Snow and SMDK5250, so moving it there
>> seems feasible and the cleanest solution to me.
>>
> 
> What I mean is that in exynos5250-pinctrl.dtsi only generic SoC pin
> groups should be defined and those more or less correspond to groups
> with samsung,pin-function set to something other than 0 (input) or 1
> (output). Now here hpd_gpio is just a normal GPIO input used as
> interrupt source to detect when a cable is plugged or unplugged. This is
> by no means generic to the SoC, because any GPIO with interrupt
> capability can be used for this purpose. This means that the whole
> pin{conf,mux} group should be defined on board level.

Exactly what I meant! :)

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
