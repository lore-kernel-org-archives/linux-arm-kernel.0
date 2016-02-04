From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 4 Feb 2016 06:41:35 -0800
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <56B35698.4020100@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
 <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
 <56B24642.8090105@codeaurora.org>
 <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
 <56B24AB5.3070001@codeaurora.org>
 <CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
 <56B2DEE4.7060901@roeck-us.net> <56B35698.4020100@codeaurora.org>
Message-ID: <56B3631F.6090304@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2016 05:48 AM, Timur Tabi wrote:
> Guenter Roeck wrote:
>> Also, if panic is enabled, the timeout needs to be adjusted accordingly
>> (to only panic after the entire timeout period has expired, not after
>> half of it). We can not panic the system after timeout / 2.
>
> It's a debugging feature, not an actual watchdog timeout panic.  That's why it's disabled by default.
>

"* When the first stage(the half timeout) is reached, WS0 interrupt is
  * triggered, at this moment the second watch period starts;
  * In the WS0 interrupt routine, panic will be triggered for saving the
  * system context.
  * If the system is getting into trouble and cannot be reset by panic or
  * restart properly by the kdump kernel(if supported), then the second
  * stage (the timeout) will be reached, system will be reset by WS1."

That doesn't sound like debugging to me.

Guenter
