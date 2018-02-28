From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 12:10:28 +0800
Subject: [PATCH 46/52] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
In-Reply-To: <20180226104505.GB8736@arm.com>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
 <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
 <20180226100518.GA11378@kroah.com>
 <3fa9ebcb-fe94-bbd6-49a7-e90c91c3905e@linaro.org>
 <20180226104505.GB8736@arm.com>
Message-ID: <a12f1c0c-1d79-768f-97e4-2ef62ebf150c@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/26/2018 06:45 PM, Will Deacon wrote:
> On Mon, Feb 26, 2018 at 06:40:42PM +0800, Alex Shi wrote:
>>
>>
>> On 02/26/2018 06:05 PM, Greg KH wrote:
>>> On Mon, Feb 26, 2018 at 04:20:20PM +0800, Alex Shi wrote:
>>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>>
>>>> ** Not yet queued for inclusion in mainline **
>>>
>>> As Marc said, this should have been a HUGE clue that we can't take this
>>> patch.  Please go re-read
>>> 	https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>>
>>
>> Thanks for comments, Greg!
>>
>> I read the rules for several times, and thought it maybe a exception for
>> this bug fix. But since MarcZ said so. We can wait. :)
> 
> The reason I added the disclaimer to the commit message was precisely to
> avoid these things accidentally going into stable. If stable diverges
> significantly from mainline, it's just going to make backports of other
> patches more difficult. So no, we shouldn't be considering an exception
> for this.
> 

Hi Will,

Got it. Thanks for explanations!
I remove all non upstream patches and put it on

git://git.linaro.org/kernel/linux-linaro-stable.git
v4.9-spectre-upstream-only

If other patches passed review. it could be got as whole branch from there.

Thanks
Alex
