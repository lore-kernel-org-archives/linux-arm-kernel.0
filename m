From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 27 Mar 2015 15:30:34 +0100
Subject: exynos5800-peach-pi: suspend/resume (still) broken
In-Reply-To: <CAM4voanJNJPMdBx5okcVYhqKyzKTctZddvV-XpWzPrA8Og_7oA@mail.gmail.com>
References: <CAMAWPa_r04tAXAXosmLk+DfwvQV0qpD+=8O7T_pwFTAozcjOgQ@mail.gmail.com>	<550953ED.10508@collabora.co.uk>	<CAM4voakvhHuVXLY2DmdGexfrqSYUqhXhg1krLwO4CCxjHQ1NCw@mail.gmail.com>	<550C47ED.3010301@collabora.co.uk>	<CAM4voamLt=6dSY-DwDb+c=KRwDWAvjvzUUnno+=+1svDqf41Qg@mail.gmail.com>	<CAM4voanUg87=Ya6azGCRz8r2=WJ0wi4ktqdn6GD6ULJsnLUMmw@mail.gmail.com>	<55155B3F.2010704@collabora.co.uk>
 <CAM4voanJNJPMdBx5okcVYhqKyzKTctZddvV-XpWzPrA8Og_7oA@mail.gmail.com>
Message-ID: <5515698A.4000708@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abhilash,

On 03/27/2015 03:06 PM, Abhilash Kesavan wrote:
> Hello Javier,
> 
> On Fri, Mar 27, 2015 at 6:59 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> Hello Abhilash,
>>
>> On 03/20/2015 06:40 PM, Abhilash Kesavan wrote:
>>>
>>> Regarding the mdma0 disablement, it looks like for the system to
>>> suspend properly the mdma0 pclk needs to stay on.
>>>
>>
>> I had time today again to work on this issue and the best
>> place I found to enable and disable the mdma0 clock is in
>> exynos5420_pm_{prepare,resume}. Please let me know if you
>> have a better idea of where the clock should be managed.
>>
> 
> Modifying exynos5420_clk_suspend in
> drivers/clk/samsung/clk-exynos5420.c would be another way to go,
> however I have not tested if this actually works.
> 

Sorry, I just posted the series: "[RFC PATCH 0/2] ARM: EXYNOS: Fix
Suspend-to-RAM on Exynos5420" before reading your email...

Please let me know if you think that is not the best appraoch and
I can come up with another one to modify the clk-exynos5420 suspend
and resume callbacks.

Another option is to use Lee Jone's clocks "always on" support [0]
that has been posted.

>> I'll send a RFC patch-set soon.
> 
> Thanks for the effort.
>

Thanks to you for all the help.

> Regards,
> Abhilash
>

Best regards,
Javier

[0]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/326616.html
