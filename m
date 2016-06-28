From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 28 Jun 2016 13:27:59 -0600
Subject: [PATCH] media: s5p-mfc fix memory leak in s5p_mfc_remove()
In-Reply-To: <57729DF1.20404@osg.samsung.com>
References: <1465847114-7427-1-git-send-email-shuahkh@osg.samsung.com>
 <025e01d1d123$7c14e620$743eb260$@samsung.com>
 <57727E2C.9040102@osg.samsung.com> <57729DF1.20404@osg.samsung.com>
Message-ID: <5772CFBF.6090909@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2016 09:55 AM, Shuah Khan wrote:
> On 06/28/2016 07:39 AM, Shuah Khan wrote:
>> On 06/28/2016 03:57 AM, Kamil Debski wrote:
>>> HI Shuah,
>>>
>>> Which branch do you base your patches on?
>>>
>>> I have trouble applying this path
>>> (https://patchwork.linuxtv.org/patch/34577/) and 
>>> "s5p-mfc fix null pointer deference in clk_core_enable()"
>>> (https://patchwork.linuxtv.org/patch/34751/) 
>>> onto current linuxtv/master.
>>>
>>> The top commit of linuxtv/master is :
>>> "commit 0db5c79989de2c68d5abb7ba891bfdb3cd3b7e05
>>> Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>>> Date:   Thu Jun 16 08:04:40 2016 -0300
>>>
>>>     [media] media-devnode.h: Fix documentation"
>>>
>>> Could you please rebase the two patches mentioned above to the
>>> linuxtv/master?
>>>
>>> Best wishes,
>>>
>>
>> I based them on linux_next. I will rebase both patches on linuxtv/master
>> and resend.
>>
> 
> Hi Kamil,
> 
> Do you need me to rebase this one:
> 
> https://patchwork.kernel.org/patch/9166119/
> 
> I will do that anyway and send three patches. I don't see the above
> in linuxtv/master
> 

Hi Kamil,

https://patchwork.kernel.org/patch/9166119/
media: s5p-mfc fix video device release double release in probe error path

and 

(https://patchwork.linuxtv.org/patch/34577/)
media: s5p-mfc fix memory leak in s5p_mfc_remove()

applied as is on top of linuxtv/master latest with top
commit

The following failed and applied with fuzz.

"s5p-mfc fix null pointer deference in clk_core_enable()"
(https://patchwork.linuxtv.org/patch/34751/) 
onto current linuxtv/master.

I generated a rebasewd patch series with the above 3 patches
and sent it.

https://www.mail-archive.com/linux-media at vger.kernel.org/msg98784.html

thanks,
-- Shuah
