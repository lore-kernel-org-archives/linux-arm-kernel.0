From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 04 Apr 2014 11:01:11 -0700
Subject: [PATCH] watchdog: sunxi: Fix compilation with C=2
In-Reply-To: <533EF270.9090308@elopez.com.ar>
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
 <533EED7A.20307@roeck-us.net> <533EF270.9090308@elopez.com.ar>
Message-ID: <533EF367.9050208@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2014 10:57 AM, Emilio L?pez wrote:
> Hi,
>
> El 04/04/14 14:35, Guenter Roeck escribi?:
>> On 04/04/2014 10:24 AM, Emilio L?pez wrote:
>>> When compiling sunxi_defconfig while using C=2, the following error
>>> causes the compilation to fail:
>>>
>>>      drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is not
>>> a valid number
>>>
>>> Fix it by using hex notation instead of the non-standard binary one
>>>
>>
>> What defines "non-standard" here ?
>
> non-standard as not part of the C standard. Binary constant notation is a GCC extension as far as I'm aware:
>
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=23479
> http://gcc.gnu.org/onlinedocs/gcc/Binary-constants.html (Note the "C Extensions" section)
>
Ok.

>> Isn't this a sparse problem that
>> should possibly
>> be fixed in sparse instead ?
>
> It could be fixed in sparse as well, I don't really mind either way. The binary notation doesn't seem to be used much, if at all, on the kernel though; most of the matches I saw when quickly grepping were comments.
>
Nah, if it is non-standard I don't think that would be a good idea.

Guenter
