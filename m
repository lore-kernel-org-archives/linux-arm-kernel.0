From: dgilbert@interlog.com (Douglas Gilbert)
Date: Wed, 07 Aug 2013 15:24:39 -0400
Subject: [PATCH 3.10-stable] at91sam9x5 rtc causes damage
In-Reply-To: <20130807190801.GB2525@kroah.com>
References: <52027AB3.1040806@interlog.com> <20130807190801.GB2525@kroah.com>
Message-ID: <52029EF7.3040105@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-07 03:08 PM, Greg KH wrote:
> On Wed, Aug 07, 2013 at 12:49:55PM -0400, Douglas Gilbert wrote:
>> This one probably needs more sign-offs but some folks seem to be
>> away. It is pretty simple and fixed in the current lk 3.11.0-rc
>> series. So it just impacts the lk 3.10 series including lk 3.10.5 .
>>
>> ChangeLog:
>>    - without this patch members of the at91sam9x5 family (e.g.
>>      at91sam9g25) that use the RTC will receive an unhandled
>>      interrupt whenever they try to write to the RTC. In the
>>      case of 9x5 SoCs that is the SYS interrupt shared with
>>      several other things such as the debug port. Thereafter
>>      the debug port becomes useless (for input), the RTC doesn't
>>      work ...
>>
>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
>
> </formletter>

Fine. I'll leave it.

Doug Gilbert
