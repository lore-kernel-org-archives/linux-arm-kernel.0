From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Sat, 02 Aug 2014 09:49:53 +0200
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <CAD=FV=XVM4FUMxjindZGXku5DZ1MkTWq=Smmt_Fs7=_i4MBFKw@mail.gmail.com>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>	<1406822910-6255-5-git-send-email-afaerber@suse.de>	<53DA936E.9060004@gmail.com>	<53DA9709.10602@suse.de>	<53DA9BA9.60808@gmail.com>
 <CAD=FV=XVM4FUMxjindZGXku5DZ1MkTWq=Smmt_Fs7=_i4MBFKw@mail.gmail.com>
Message-ID: <53DC9821.3010108@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.08.2014 07:15, schrieb Doug Anderson:
> On Thu, Jul 31, 2014 at 12:40 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> On 31.07.2014 21:20, Andreas F?rber wrote:
>>> Am 31.07.2014 21:05, schrieb Tomasz Figa:
>>>> On 31.07.2014 18:08, Andreas F?rber wrote:
>>>>> +&sd1_clk {
>>>>> +   samsung,pin-drv = <0>;
>>>>> +};
>>>>> +
>>>>> +&sd1_cmd {
>>>>> +   samsung,pin-pud = <3>;
>>>>> +   samsung,pin-drv = <0>;
>>>>> +};
>>>>> +
>>>>> +&sd1_cd {
>>>>> +   samsung,pin-drv = <0>;
>>>>> +};
>>>>> +
>>>>> +&sd1_bus4 {
>>>>> +   samsung,pin-drv = <0>;
>>>>> +};
>>>>
>>>> Here generic settings are being overridden, so it might be a good idea
>>>> to explain why, like with i2c pull-up above.
>>>
>>> Snow does not have an explanation either, so please suggest what comment
>>> you'd like to see. Consider me just a user with no specs. :)
>>
>> Doug, Vincent, someone else?
> 
> The comment is just in a different place--it's in the dw_mmc node.
> Probably belongs here, though:
> 
>                 /*
>                  * Wifi is a SiP, so can keep drive strengths low
>                  * to reduce EMI.
>                  */
> 

I did copy such a comment for the MMC node in v5, still present in v6.

Andreas

> I guess the cmd line isn't documented.  There is no external pull on
> the command line and on most boards there is one.  Our hardware guys
> thought we didn't need it and apparently we don't...

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
