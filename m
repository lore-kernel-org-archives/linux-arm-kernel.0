From: wg@grandegger.com (Wolfgang Grandegger)
Date: Tue, 18 Dec 2012 07:51:02 +0100
Subject: [PATCH RESEND 0/6 v10] gpio: Add block GPIO
In-Reply-To: <50CF8FA9.8050609@antcom.de>
References: <1355495185-24220-1-git-send-email-stigge@antcom.de>
 <50CB68AB.5070806@grandegger.com> <50CBBB25.20002@antcom.de>
 <50CF03FB.2030100@grandegger.com> <50CF0744.7040404@grandegger.com>
 <50CF1EF1.2070601@antcom.de> <50CF237E.5020409@antcom.de>
 <50CF4838.9000401@grandegger.com> <50CF5327.6070205@antcom.de>
 <50CF584E.1040601@grandegger.com> <50CF5E45.5030104@antcom.de>
 <50CF76D3.9030708@grandegger.com> <50CF8FA9.8050609@antcom.de>
Message-ID: <50D01256.1020105@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 10:33 PM, Roland Stigge wrote:
> On 17/12/12 20:47, Wolfgang Grandegger wrote:
>> On 12/17/2012 07:02 PM, Roland Stigge wrote:
>>> On 12/17/2012 06:37 PM, Wolfgang Grandegger wrote:
>>>> 	/* Do synchronous data output with a single write access */
>>>> 	__raw_writel(~mask, pio + PIO_OWDR);
>>>> 	__raw_writel(mask, pio + PIO_OWER);
>>>> 	__raw_writel(val, pio + PIO_ODSR);
>>>>
>>>> For caching we would need a storage. Not sure if it's worth compared to
>>>> a context switch into the kernel.
>>>
>>> Block GPIO is not only for you in userspace. ;-) You can also implement
>>> efficient n-bit bus I/O in kernel drivers, n-bit-banging. :-) So not
>>> always context switches involved.
>>
>> OK, what do you think about the following untested patch:
> 
> Looks good!
> 
> Why "untested"? ;-)

Because I didn't have a chance to test it yet. Will do tomorrow.

Wolfgang.
