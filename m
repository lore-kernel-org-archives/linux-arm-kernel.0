From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 27 Mar 2015 19:36:02 +0530
Subject: exynos5800-peach-pi: suspend/resume (still) broken
In-Reply-To: <55155B3F.2010704@collabora.co.uk>
References: <CAMAWPa_r04tAXAXosmLk+DfwvQV0qpD+=8O7T_pwFTAozcjOgQ@mail.gmail.com>
 <550953ED.10508@collabora.co.uk>
 <CAM4voakvhHuVXLY2DmdGexfrqSYUqhXhg1krLwO4CCxjHQ1NCw@mail.gmail.com>
 <550C47ED.3010301@collabora.co.uk>
 <CAM4voamLt=6dSY-DwDb+c=KRwDWAvjvzUUnno+=+1svDqf41Qg@mail.gmail.com>
 <CAM4voanUg87=Ya6azGCRz8r2=WJ0wi4ktqdn6GD6ULJsnLUMmw@mail.gmail.com>
 <55155B3F.2010704@collabora.co.uk>
Message-ID: <CAM4voanJNJPMdBx5okcVYhqKyzKTctZddvV-XpWzPrA8Og_7oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Javier,

On Fri, Mar 27, 2015 at 6:59 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Abhilash,
>
> On 03/20/2015 06:40 PM, Abhilash Kesavan wrote:
>>
>> Regarding the mdma0 disablement, it looks like for the system to
>> suspend properly the mdma0 pclk needs to stay on.
>>
>
> I had time today again to work on this issue and the best
> place I found to enable and disable the mdma0 clock is in
> exynos5420_pm_{prepare,resume}. Please let me know if you
> have a better idea of where the clock should be managed.
>

Modifying exynos5420_clk_suspend in
drivers/clk/samsung/clk-exynos5420.c would be another way to go,
however I have not tested if this actually works.

> I'll send a RFC patch-set soon.

Thanks for the effort.

Regards,
Abhilash
